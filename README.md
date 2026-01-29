# lab-cefet

> Bash scripts para CMD (Windows) que visam instalar programas necessários ao Laboratórios do Bacharelado em Sistemas de Informação do CEFET/RJ Nova Friburgo

## Como utilizar

> ⚠️ Use por sua conta e risco ⚠️

### Forma 1: Instalando seletivamente

1. Baixe [lab-cefet-main.zip](https://github.com/thiagodp/lab-cefet/archive/refs/heads/main.zip).
2. Extraia `lab-cefet-main.zip` para `C:\lab-cefet-main` (ou outra pasta qualquer).
3. Clique com o botão direito no botão **Iniciar (logo do Windows)**, clique em **"Terminal (Administrador)"** e confirme para abrir o terminal.
4. Execute `cd C:\lab-cefet-main` e depois `dir`.
5. Execute o `.bat` desejado. Por exemplo: `install-web.bat`.


### Forma 2: Instalando todos os programas

1. Baixe [lab-cefet-main.zip](https://github.com/thiagodp/lab-cefet/archive/refs/heads/main.zip).
2. Extraia `lab-cefet-main.zip` para `C:\lab-cefet-main` (ou outra pasta qualquer).
3. Clique com o botão direito no botão Iniciar (logo do Windows), clique em "Terminal (Administrador)" e confirme para abrir o terminal.
4. Execute `cd C:\lab-cefet-main` e então `install`.



## Programas instalados por cada arquivo .bat

### [`install-web.bat`](install-web.bat)

> Instala cada programa em `C:\dev`.

- Git
- cURL
- PHP
- Composer
- Apache
- MariaDB - inclui MySQL; usuário `root` e senha `root`
- PHPMyAdmin - em `C:\dev\apache\Apache24\htdocs\phpmyadmin`
- NodeJS
- PNPM
- Bun
- Putty
- Scrcpy

💡 Observação: Já integra o Apache ao PHP, usando [apache-php](https://github.com/thiagodp/apache-php).


### [`install-cpp.bat`](install-cpp.bat)

> Instala cada programa em `C:\dev`.

- CodeBlocks com MinGW
- Arduino IDE


### [`install-editor.bat`](install-editor.bat)

> Instala cada programa em `C:\dev`.

- Notepad++
- VSCode
- Extensões úteis para VSCode


### [`install-java.bat`](install-java.bat)

> Instala cada programa em `C:\dev`.

- JDK
- Eclipse para JEE
- Intellij Community


### [`install-office.bat`](install-office.bat)

> Instala cada programa em `C:\Program Files`.

- Adobe Acrobat
- Google Chrome
- Mozilla Firefox
- IrfanView e plug-ins
- Microsoft Office
- LibreOffice e arquivos de ajuda


### [`install-ops.bat`](install-ops.bat)

> Instala cada programa em `C:\ops`.

- Windows Subsystem for Linux (WSL)
- PowerShell
- Windows Terminal (WT)
- Ubuntu (para WSL)
- Docker Desktop
- Oracle VirtualBox


### [`install-python.bat`](install-python.bat)

> Instala cada programa em `C:\dev`.

- Python
- Anaconda


### [`install.bat`](install.bat)

- Todos os programas dos `.bat` listados acima.


## Licença

MIT ©️ [Thiago Delgado Pinto](https://github.com/thiagodp)