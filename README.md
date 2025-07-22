# 🎥 YouTube Video → Unique Slides → PDF

This script downloads a YouTube video, extracts **only unique frames**, and merges them into a **single PDF**. Perfect for saving lecture slides, tutorials, or presentations without duplicate screenshots.

---

## ✨ Features

✅ Downloads any YouTube video via `yt-dlp`  
✅ Captures frames every few seconds (configurable)  
✅ Uses **perceptual hashing** to remove duplicate frames  
✅ Combines all unique frames into a **PDF**  
✅ Cleans up all temporary files automatically

---

## 📸 How It Works

1. **Download video** from YouTube  
2. **Extract frames** every N seconds using `ffmpeg`  
3. **Generate perceptual hash** for each frame  
4. **Skip duplicates** (frames with same hash)  
5. Merge final frames into a **PDF**

---

## 🛠️ Requirements

Make sure you have these installed:

```bash
sudo apt update
sudo apt install ffmpeg imagemagick img2pdf -y
pip install yt-dlp
```

---

## 🚀 Usage

1. Clone this repo:  
   ```bash
   git clone https://github.com/yourusername/yt2pdf.git
   cd yt2pdf
   ```

2. Make the script executable:  
   ```bash
   chmod +x yt2pdf.sh
   mv yt2.pdf.sh yt2pdf
   mv yt2pdf /usr/local/bin
   ```

3. Run the script:  
   ```bash
   yt2pdg
   ```

4. Enter your **YouTube URL**  
   - The script downloads the video  
   - Extracts unique frames  
   - Saves a **`output.pdf`**

---

## ⚙️ Configuration

You can edit these variables inside the script:

- `FRAME_INTERVAL=2` → Capture frame every 2 seconds  
- `OUTPUT_PDF="output.pdf"` → Change PDF name

---

## 📂 Output

- `output.pdf` → Contains only **unique slides**  
- No duplicate images  
- Temporary files & video are auto-removed

---


### 🏃 Running the Script

![Running Script](screenshots/running_script.png)

### 🖼️ Extracted Unique Frames

![Unique Frames](screenshots/unique_frames.png)

### 📄 Final PDF Example

![PDF Output](screenshots/pdf_example.png)

> *(Screenshots are just placeholders. Add your own images inside a `screenshots/` folder.)*

---

## 📝 Example

```bash
./yt2pdf.sh
Enter YouTube video URL: https://youtu.be/example
[*] Downloading video...
[*] Extracting frames...
[*] Filtering unique frames...
[*] Creating PDF...
[✔] Done! PDF saved as: output.pdf
```

---

## 📌 Why Use This?

✔ Save time extracting slides from long lectures  
✔ Get **clean PDF slides** without duplicates  
✔ Works offline after dependencies are installed

---

## 📜 License

MIT License – free to use & modify.
