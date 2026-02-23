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

Install Python 3.12
Install Nodejs
Install Docker
Microsoft Visual C++ Redistributable
	**Why?** Required by PyTorch and other deep learning libraries. Without this, you will get `WinError 1114`.
	- **Download**: [VC_redist.x64.exe](https://aka.ms/vs/17/release/vc_redist.x64.exe)
	- **Action**: Run the installer and **restart your computer**.

Build Tools for Visual Studio
	**Why?** Needed to compile some Python packages (like Detectron2) from source.
	- **Download**: [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
	- **Action**: Install "Desktop development with C++".

Poppler (for PDF Processing)
	**Why?** Unstructured uses this to read PDF files and extract images.
	- **Download**: [Release 24.02.0 (or latest)](https://github.com/oschwartz10612/poppler-windows/releases/)
	- **Steps**:
	  1. Download the `.7z` or `.zip` file.
	  2. Extract it to a permanent location, e.g., `C:\Program Files\poppler`.
	  3. **Critical**: Add `C:\Program Files\poppler\Library\bin` to your System **PATH** environment variable.

Tesseract OCR
	**Why?** Required to extract text from images or scanned PDFs.
	- **Download**: [Tesseract Installer](https://github.com/UB-Mannheim/tesseract/wiki)
	- **Steps**:
	  1. Run the installer.
	  2. Install to `C:\Program Files\Tesseract-OCR`.
	  3. **Critical**: Add `C:\Program Files\Tesseract-OCR` to your System **PATH**.
	  
Poetry
	Got to https://python-poetry.org/docs/#installing-with-the-official-installer
	Install poetry in powershell using: (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
	Add to Environment Path
	
Setup env
	Server
		# Redis Configuration
		REDIS_URL=redis://localhost:6379/0

		# Application Configuration
		DOMAIN=http://localhost:3000/

		# Supabase
		SUPABASE_API_URL=http://127.0.0.1:54321
		SUPABASE_SECRET_KEY=

		# Clerk
		CLERK_SECRET_KEY=

		#Tigris
		AWS_ACCESS_KEY_ID=
		AWS_SECRET_ACCESS_KEY=
		AWS_ENDPOINT_URL_S3=https://t3.storage.dev
		AWS_ENDPOINT_URL_IAM=https://iam.storage.dev
		AWS_REGION=auto

		S3_BUCKET_NAME=

		# OpenAI
		OPENAI_API_KEY=

		# Scrapbee
		SCRAPINGBEE_API_KEY=
		
	Client
		NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=
		CLERK_SECRET_KEY=
		NODE_TLS_REJECT_UNAUTHORIZED=0
		