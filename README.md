# bt-obex-lab 🚀

**Beginner lab:** Push harmless files from a Linux host (Kali/Ubuntu) to an Android device via Bluetooth OBEX/OPP.  
Ethical use only — you own the target device. 📱💻

---

## Features
- Auto-generates harmless text files
- Push files over Bluetooth using `obexftp` or `bluetooth-sendto`
- Simple, safe, and beginner-friendly

---

## Manual pairing & interactive push

Before using `scripts/push-file.sh`, pair and/or trust the phone interactively so automated pushes work reliably.

> Keep the phone **unlocked** and the Bluetooth settings page open while pairing. If you are running this from a VM, prefer doing pairing & pushes on the **host** unless you have a USB Bluetooth dongle passed into the VM.

### Interactive `bluetoothctl` flow (run in a terminal)
```bash
sudo bluetoothctl
# inside bluetoothctl:
power on            # turn the controller on
agent on            # enable an agent to handle pairing dialogs
default-agent       # make that agent the default so it can accept pair requests
scan on             # start discovery; wait until you see your phone appear (NEW Device <MAC> <NAME>)
pair <PHONE-MAC>    # pair; confirm the PIN on the phone if asked
trust <PHONE-MAC>   # mark the device trusted (reduces prompts later)
connect <PHONE-MAC> # optional: connect now, some phones accept pushes without explicit connect
scan off
exit
```

What these do:
- ```power on``` — ensure the Bluetooth controller is powered.

- ```agent on``` + ```default-agent``` — register an interactive agent so ```bluetoothctl``` can handle pairing prompts.

- ```scan on``` — discover nearby devices; note the phone MAC (format ```AA:BB:CC:DD:EE:FF```).

- ```pair``` — start pairing; accept the confirmation on the phone.

- ```trust``` — allow automatic reconnections/acceptance in the future.

- ```connect``` — actively establish a connection (not always required for OBEX pushes).

---

## Manual file push
Create a harmless file:
```bash
cat > harmless_spam.txt <<'EOF'
Hello from my lab — harmless test file.
Accept the incoming transfer.
EOF
```

Try pushing with ```obexftp``` (CLI):
```bash
obexftp -b <PHONE-MAC> -p harmless_spam.txt
```

Or use the desktop helper:
```bash
bluetooth-sendto --device=<PHONE-MAC> harmless_spam.txt
```

---

## Notes & troubleshooting
- If Device ```<MAC>``` not available appears in ```bluetoothctl```, make sure the phone is unlocked, discoverable, and not auto‑connected to another device (TV/speaker). Try remove ```<MAC>``` and re-pair.
- After a successful interactive pairing/trust, the ```scripts/push-file.sh``` script will automate the harmless pushes without repeating manual pairing steps.

---

## Using the script

```bash
cd scripts
./push-file.sh <phone-mac> [count] [delay_seconds]
```

- ```<phone-mac>``` → Bluetooth MAC of your Android device
- ```[count]``` → Number of files to send (default: 1)
- ```[delay_seconds]``` → Delay between pushes (default: 3)

Check your phone’s Downloads/Bluetooth folder for received files. ✅

## License
This project is licensed under the [MIT License](LICENSE).