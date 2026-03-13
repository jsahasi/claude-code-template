# RAG - Query Your Documents with AI

A skill to index and query documents using Retrieval-Augmented Generation.

## Usage

**Index a folder:**
```
/rag index <folder_path>
```

**Query documents:**
```
/rag <folder_path> "<question>"
```

**Examples:**
```
/rag index ./docs
/rag ./docs "How does authentication work?"
/rag ./my-project "What are the main components?"
```

## Arguments

$ARGUMENTS

## Instructions

You are helping the user query their documents using RAG (Retrieval-Augmented Generation).

<!-- CUSTOMIZE: Set RAG_APP_PATH to the location of your rag_app installation -->
The RAG application is located at: `$RAG_APP_PATH`

### If the user wants to INDEX documents:

Run this command to index the folder:
```bash
cd "$RAG_APP_PATH" && source venv/Scripts/activate 2>/dev/null || source venv/bin/activate 2>/dev/null || true && python main.py index "<folder_path>"
```

Report the number of document chunks indexed.

### If the user wants to QUERY documents:

1. First check if the folder is indexed:
```bash
cd "$RAG_APP_PATH" && source venv/Scripts/activate 2>/dev/null || source venv/bin/activate 2>/dev/null || true && python main.py status "<folder_path>"
```

2. If not indexed, index it first, then query.

3. Run the query:
```bash
cd "$RAG_APP_PATH" && source venv/Scripts/activate 2>/dev/null || source venv/bin/activate 2>/dev/null || true && python main.py query "<folder_path>" "<question>"
```

4. Present the answer clearly to the user.

### Options

You can add these flags:
- `--llm anthropic` or `--llm openai` - Choose LLM provider
- `--embedding local` or `--embedding openai` - Choose embedding provider
- `--rebuild` - Force re-index when indexing

### Important

- Always use absolute paths when possible
- If the query fails due to missing index, offer to index first
- Keep responses concise and actionable
