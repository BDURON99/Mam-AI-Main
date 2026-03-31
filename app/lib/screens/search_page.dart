import 'dart:async';
import 'dart:io';
import 'package:app/screens/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

const DEEP_RED_BRAND_COLOR = Color.fromARGB(255, 170, 43, 66);

/// This is the search page. The user interacts with the model by typing in
/// the search bar or clicking one of the suggestion chips.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();

  /// Request the LLM to initialise itself (used in intro)
  static void requestLlmPreinit() {
    print("init LLM");
    _SearchPageState.platform.invokeMethod("ensureInit");
  }

  /// Wait for the LLM to be initialised (like request preinit but also waits)
  static Future<void> waitForLlmInit() {
    return _SearchPageState.platform.invokeMethod("ensureInit");
  }
}

class SearchPageArguments {
  const SearchPageArguments({required this.documentsDirectory});
  final Directory documentsDirectory;
}

class _SearchPageState extends State<SearchPage> {
  /// Response from the LLM (summary)
  String? _latestMessage;

  /// This is passed via navigator arguments, so it is null until first build
  /// and then never again. This isn't `late` so we can avoid reinitialising it
  /// over and over again
  Directory? documentsDirectory;

  /// Documents retrieved from RAG
  List<RetrievedDocument> _retrievedDocuments = List.empty();

  static const platform = MethodChannel(
    "io.github.mzsfighters.mam_ai/request_generation",
  );
  static const latestMessageStream = EventChannel(
    "io.github.mzsfighters.mam_ai/latest_message",
  );
  StreamSubscription? _latestMessageSubscription;
  SearchController controller = SearchController();
  bool _searchedBefore = false;

  /// Request the model to generate a prompt - this calls into the Android code
  /// (see app/android/app/src/main/kotlin/com/example/app/MainActivity.kt)
  Future<void> _generateResponse(String prompt) async {
    try {
      setState(() {
        _searchedBefore = true;
        _latestMessage = null;
      });

      await platform.invokeMethod<int>("generateResponse", prompt);
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  void _startListeningForLatestMessage() {
    _latestMessageSubscription = latestMessageStream
        .receiveBroadcastStream()
        .listen(_onLatestMessageUpdate);
  }

  /// Update the latest message & documents as the model generates
  void _onLatestMessageUpdate(value) {
    setState(() {
      if (value.containsKey("response")) {
        _latestMessage = value["response"];
      }

      if (value.containsKey("results")) {
        List<Object?> docs = value["results"];
        _retrievedDocuments = docs
            .map<RetrievedDocument>(
              (raw) => RetrievedDocument.fromMap(
                raw as Map<Object?, Object?>,
                documentsDirectory!,
              ),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _latestMessageSubscription?.cancel();
  }

  /// Called when the user clicks a chip or presses search
  void onSubmit(String text) {
    // For some reason, if we close an already closed view, it will make the
    // entire screen black - I think that this is probably poorly-isolated code
    // given that it affects the entire _screen_ and not only the widget it is
    // supposed to control
    if (controller.isOpen) {
      controller.closeView(text);
    } else {
      // We still want to set the text even if the search view is closed
      controller.text = text;
    }

    _generateResponse(text);
  }

  @override
  Widget build(BuildContext context) {
    if (documentsDirectory == null) {
      SearchPageArguments args =
          ModalRoute.of(context)!.settings.arguments as SearchPageArguments;
      documentsDirectory = args.documentsDirectory;
    }

    // Some suggested prompt
    var examples = [
      "Preparing for home birth",
      "Infection risks childbirth",
      "Bleeding after delivery",
      "Newborn not breathing",
    ];
    var history = []; // Search history TBD

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_latestMessageSubscription == null) {
        _startListeningForLatestMessage();
      }
    });

    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          toolbarHeight: 88,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Image.asset('images/logo-white.png', height: 64),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 0,
                children: [
                  Text(
                    'MAM*AI',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    'Clinical Search',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: DEEP_RED_BRAND_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 24, // TODO: replace by 0 if move search bar down again
            bottom: 24,
            left: 24,
            right: 24,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: SearchAnchor(
                      shrinkWrap: true,
                      searchController: controller,
                      viewOnSubmitted: onSubmit,
                      viewBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.surface,
                      builder:
                          (BuildContext context, SearchController controller) {
                            return SearchBar(
                              constraints: const BoxConstraints(
                                minWidth: 360.0,
                                minHeight: 56.0,
                              ),
                              padding: WidgetStatePropertyAll(
                                EdgeInsetsDirectional.only(start: 12, end: 8),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.surface,
                              ),
                              elevation: WidgetStatePropertyAll(0),
                              side: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.focused)) {
                                  return BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceDim,
                                    width: 1.5,
                                  );
                                }
                                return BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceDim,
                                  width: 1,
                                );
                              }),
                              trailing: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.search,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                              controller: controller,
                              hintText: "Search in medical guidelines...",
                              hintStyle: WidgetStatePropertyAll(
                                TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              textStyle: WidgetStatePropertyAll(
                                TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              onSubmitted: onSubmit,
                              onTap: controller.openView,
                              onChanged: (_) => controller.openView(),
                            );
                          },

                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                            RegExp regex = RegExp(
                              RegExp.escape(controller.text.toLowerCase()),
                            );
                            return history
                                .map(
                                  (text) => SearchSuggestionTile(
                                    text,
                                    SuggestionType.history,
                                    onPressed: onSubmit,
                                  ),
                                )
                                .followedBy(
                                  examples.map(
                                    (text) => SearchSuggestionTile(
                                      text,
                                      SuggestionType.example,
                                      onPressed: onSubmit,
                                    ),
                                  ),
                                )
                                .where(
                                  (tile) =>
                                      regex.hasMatch(tile.text.toLowerCase()),
                                )
                                .toList();
                          },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: (_searchedBefore)
                            ? SearchOutput(
                                summary: _latestMessage,
                                retrievedDocuments: _retrievedDocuments,
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: history
                                      .map(
                                        (text) => SearchSuggestionChip(
                                          text,
                                          SuggestionType.history,
                                          onPressed: onSubmit,
                                        ),
                                      )
                                      .followedBy(
                                        examples.map(
                                          (text) => SearchSuggestionChip(
                                            text,
                                            SuggestionType.example,
                                            onPressed: onSubmit,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),

                //const SizedBox(height: 8), //TODO: add if search bar move up again
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated "Generating response..." indicator shown while loading
class _ThinkingIndicator extends StatefulWidget {
  final bool hasDocs;
  const _ThinkingIndicator({required this.hasDocs});

  @override
  State<_ThinkingIndicator> createState() => _ThinkingIndicatorState();
}

class _ThinkingIndicatorState extends State<_ThinkingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = 'Generating response';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final dots = '.' * ((_controller.value * 3).floor() + 1);
          return Text(
            '$label$dots',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          );
        },
      ),
    );
  }
}

/// We have two types of suggestion chips - example & history. Only example
/// is used so far
enum SuggestionType { example, history }

/// A search suggestion appearing in the dropdown list
class SearchSuggestionTile extends StatelessWidget {
  const SearchSuggestionTile(
    this.text,
    this.type, {
    super.key,
    required this.onPressed,
  });

  final String text;
  final Function(String) onPressed;
  final SuggestionType type;

  @override
  Widget build(BuildContext context) {
    Icon icon;
    Color? textColor;

    switch (type) {
      case SuggestionType.example:
        textColor = Theme.of(context).colorScheme.primary;
        icon = Icon(
          Icons.auto_awesome,
          color: Theme.of(context).colorScheme.primary,
        );
        break;

      case SuggestionType.history:
        icon = Icon(Icons.history);
        break;
    }

    return ListTile(
      leading: icon,
      title: Text(text, style: TextStyle(color: textColor)),
      onTap: () => onPressed(text),
    );
  }
}

/// A search suggestion chip
class SearchSuggestionChip extends StatelessWidget {
  const SearchSuggestionChip(
    this.text,
    this.type, {
    super.key,
    required this.onPressed,
  });

  final String text;
  final Function(String) onPressed;
  final SuggestionType type;

  @override
  Widget build(BuildContext context) {
    Icon icon;
    Color? bgColor;
    Color? textColor;
    Color borderColor;

    switch (type) {
      case SuggestionType.example:
        icon = Icon(
          Icons.auto_awesome,
          color: Theme.of(context).colorScheme.primary,
        );
        bgColor = Theme.of(context).colorScheme.surfaceContainerLow;
        textColor = Theme.of(context).colorScheme.primary;
        borderColor = Theme.of(context).colorScheme.primary;
        break;

      case SuggestionType.history:
        textColor = Theme.of(context).colorScheme.onSurface;
        icon = Icon(Icons.history, color: textColor);
        bgColor = null;
        borderColor = Theme.of(context).colorScheme.outline;
        break;
    }

    return ChipTheme(
      data: ChipThemeData(
        labelStyle: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        padding: EdgeInsets.all(4),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      child: ActionChip(
        avatar: icon,
        label: Text(text),
        onPressed: () => onPressed(text),
      ),
    );
  }
}

class RetrievedDocument {
  const RetrievedDocument({
    required this.documentName,
    required this.page,
    required this.text,
    required this.filePath,
  });

  final String documentName;
  final int page;
  final String text;
  final String filePath;

  static RetrievedDocument fromMap(
    Map<Object?, Object?> properties,
    Directory documentsDir,
  ) {
    final name = properties["title"] as String;
    final page = properties["page"] as int;
    print("FILE PATH -> ${documentsDir.path}$name.pdf");
    // TODO https://stackoverflow.com/questions/38200282/android-os-fileuriexposedexception-file-storage-emulated-0-test-txt-exposed
    return RetrievedDocument(
      documentName: name,
      page: page,
      text: properties["text"] as String,
      filePath: "${documentsDir.path}$name.pdf",
    );
  }
}

/// Guidelines widget
class ExpandableDocumentCard extends StatefulWidget {
  final RetrievedDocument doc;

  const ExpandableDocumentCard({super.key, required this.doc});

  @override
  State<ExpandableDocumentCard> createState() => _ExpandableDocumentCardState();
}

class _ExpandableDocumentCardState extends State<ExpandableDocumentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final doc = widget.doc;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        side: BorderSide(color: Theme.of(context).colorScheme.surfaceDim),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/pdf',
            arguments: PdfViewArguments(
              path: doc.filePath,
              title: doc.documentName,
              page: doc.page,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.book_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${doc.documentName.replaceAll('_', ' ')}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    TextSpan(
                      text: "   Page ${doc.page}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Icon(
                Icons.open_in_new,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              contentPadding: const EdgeInsetsDirectional.only(
                start: 24.0,
                top: 8,
                end: 24.0,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 24.0,
                top: 0,
                end: 24.0,
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _isExpanded
                      ? MarkdownBlock(
                          data: doc.text,
                          config: MarkdownConfig(
                            configs: [
                              PConfig(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(height: 0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          top: 6,
                          bottom: 6,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 24,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _isExpanded ? 'Hide extract' : 'See extract',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The main widget for the search summary
class SearchOutput extends StatefulWidget {
  const SearchOutput({
    super.key,
    required this.summary,
    required this.retrievedDocuments,
  });
  final String? summary;
  final List<RetrievedDocument> retrievedDocuments;

  @override
  State<SearchOutput> createState() => SearchOutputState();
}

class SearchOutputState extends State<SearchOutput> {
  @override
  Widget build(BuildContext context) {
    if (widget.summary == null) {
      return _ThinkingIndicator(hasDocs: widget.summary == null);
      // Center(
      //   child: SizedBox(
      //     width: 48,
      //     height: 48,
      //     child: CircularProgressIndicator(
      //       color: Theme.of(context).colorScheme.primary,
      //       strokeCap: StrokeCap.round,
      //     ),
      //   ),
      // );
    }

    final retrievedDocs = widget.retrievedDocuments.map((doc) {
      return ExpandableDocumentCard(doc: doc);
    }).toList();

    return Column(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          shadowColor: Colors.white,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                title: Text(
                  'Generated summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: 'Read with care. ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: [
                      TextSpan(
                        text: 'AI can make serious mistakes!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                contentPadding: const EdgeInsetsDirectional.only(
                  start: 8,// 24.0,
                  top: 8,
                  end: 8, //24.0,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 8,//24.0,
                  end: 8, //24.0,
                  bottom: 16.0,
                ),
                child: MarkdownBlock(
                  data: widget.summary!,
                  config: MarkdownConfig(
                    configs: [
                      PConfig(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ...retrievedDocs,
      ],
    );
  }
}
