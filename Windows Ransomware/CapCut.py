import os
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
from Crypto import Random

# ✅ Target file or folder to encrypt
file_to_encrypt = r"C:\Important_File"  # Can be a file or folder
password = "Faizal200@123"

def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()

def pad(data):
    padding = AES.block_size - len(data) % AES.block_size
    return data + bytes([padding]) * padding

def encrypt_file(file_path):
    if file_path.endswith(".encrypted"):
        return

    try:
        key = get_aes_key(password)

        with open(file_path, 'rb') as f:
            data = f.read()

        data = pad(data)
        iv = Random.new().read(AES.block_size)
        cipher = AES.new(key, AES.MODE_CBC, iv)
        encrypted_data = iv + cipher.encrypt(data)

        with open(file_path + ".encrypted", 'wb') as f:
            f.write(encrypted_data)

        os.remove(file_path)
        print(f"✅ Encrypted: {file_path}")

    except Exception as e:
        print(f"❌ Failed: {file_path} --> {e}")

def process_path(path):
    if os.path.isfile(path):
        encrypt_file(path)
    elif os.path.isdir(path):
        for root, dirs, files in os.walk(path):
            for file in files:
                full_path = os.path.join(root, file)
                encrypt_file(full_path)
    else:
        print("❌ Invalid path")

# 🚀 Run
process_path(file_to_encrypt)
