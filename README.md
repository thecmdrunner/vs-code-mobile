# vs-code-mobile (WORK IN PROGRESS)

### Simple and Quick way to use VS Code Server on a phone without root/jailbreak.

This project uses [code-server](https://github.com/cdr/code-server/) to install VS Code on your phone
It can be used in the phone's browser or any other device on the same network.  

### Pre-Requisites

- A phone running either - 
  - Android
  - Linux
  - iOS

- Terminal emulator 
  - **Android**: Termux from [F-Droid](https://f-droid.org/en/packages/com.termux/) or [Play Store](https://play.google.com/store/apps/details?id=com.termux).
  - **Linux**: Any terminal app works good.
  - **iOS**: [iSH](https://ish.app) from [App Store](https://apps.apple.com/us/app/ish-shell/id1436902243) or [AltStore](https://ish.app/altstore).

- A network connection (VPN might cause problems when accessing via another device on the network)
- Common Sense (optional)

## ANDROID

### Step 1: One liner script

Open Termux and paste the command below

```bash
curl -fsSL https://git.io/JYLt6 | bash
```

### Step 2: Integrating system storage

If you want to be able to access your phone's storage from VS Code and Termux, accept the storage permission as shown below.



### Step 3: Starting the server

Run `code-server` from the terminal to start VS Code server. You may also set it to auto-start when termux is opened, by putting `code-server` in your `~/.bashrc` or `~/.zshrc` file.

#### Note: Password authentication is disabled by default, but you must edit the `~/.config/code-server/config.yaml` to enable password authentication and change the default password before running it in a production environment.

```yaml
...
auth: password
password: somestrongpassword 
...
```

### Step 4: Run VS Code in Browser

Visit **http://127.0.0.1:8080** and enter your _password_ that you set in **Step 3**.

### Step 5: Further Setup and useful tweaks

 - Select a **dark theme** by going to  ⚙️  -> **Color Theme** -> **Dark/Dark+**
