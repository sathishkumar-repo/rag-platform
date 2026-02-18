What is RAG?

**RAG** stands for **Retrieval-Augmented Generation**.

In simple terms, **RAG combines search + AI generation** so an AI can give **more accurate, up-to-date, and context-aware answers**.

---

## Why RAG is needed

LLMs (like ChatGPT) have limitations:

* They don’t know your **private data** (DBs, PDFs, logs, internal docs)
* Their knowledge can be **outdated**
* They can **hallucinate** when unsure

**RAG fixes this** by letting the model *look up relevant information first* and then generate the answer.

---

## How RAG works (step-by-step)

### 1️⃣ Store your knowledge

Your data (PDFs, DB rows, emails, APIs, docs, etc.) is:

* Split into chunks
* Converted into **embeddings**
* Stored in a **vector database**

Examples:

* Azure AI Search
* Pinecone
* FAISS
* Weaviate

---

### 2️⃣ User asks a question

Example:

> “Why did the PBB consent fail on 21-Dec-2025?”

---

### 3️⃣ Retrieve relevant context

The system:

* Converts the question into an embedding
* Finds **similar chunks** from the vector DB
* Retrieves only the **most relevant content**

---

### 4️⃣ Generate the answer

The retrieved content is injected into the prompt:

> “Answer using ONLY the information below…”

The LLM then generates a **grounded response**.

---

## Simple RAG architecture

```
User Question
     ↓
Embedding Model
     ↓
Vector Database (Search)
     ↓
Relevant Documents
     ↓
LLM (GPT)
     ↓
Final Answer
```

---