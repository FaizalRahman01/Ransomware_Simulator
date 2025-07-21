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
