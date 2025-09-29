# bt-obex-lab 🚀

**Beginner lab:** Push harmless files from a Linux host (Kali/Ubuntu) to an Android device via Bluetooth OBEX/OPP.  
Ethical use only — you own the target device. 📱💻

---

## Features
- Auto-generates harmless text files
- Push files over Bluetooth using `obexftp` or `bluetooth-sendto`
- Simple, safe, and beginner-friendly

---

## Usage

```bash
cd scripts
./push-file.sh <phone-mac> [count] [delay_seconds]
```

```bash <phone-mac>``` → Bluetooth MAC of your Android device
```bash [count]``` → Number of files to send (default: 1)
```bash [delay_seconds]``` → Delay between pushes (default: 3)

Check your phone’s Downloads/Bluetooth folder for received files. ✅

## License
This project is licensed under the [MIT License](LICENSE).