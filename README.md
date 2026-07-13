# lab-cefet

> Bash scripts para CMD (Windows) que instalam programas necessários aos Laboratórios do Bacharelado em Sistemas de Informação do CEFET/RJ Nova Friburgo

👉 Criado para o Prompt de Comando (CMD). Não funciona no PowerShell.

## Como utilizar

> ⚠️ Use por sua conta e risco ⚠️

### Forma 1: Instalando seletivamente

1. Baixe [lab-cefet-main.zip](https://github.com/thiagodp/lab-cefet/archive/refs/heads/main.zip).
2. Extraia `lab-cefet-main.zip` para `C:\lab-cefet-main` (ou outra pasta qualquer).
3. Clique no menu **Iniciar (logo do Windows)**, digite `Prompt de Comando`, clique em **"Executar como Administrador"** e confirme para abrir o terminal.
4. Execute `cd C:\lab-cefet-main` e depois `dir`.
5. Execute o `.bat` desejado. Por exemplo: `install-web.bat`.


### Forma 2: Instalando todos os programas

1. Baixe [lab-cefet-main.zip](https://github.com/thiagodp/lab-cefet/archive/refs/heads/main.zip).
2. Extraia `lab-cefet-main.zip` para `C:\lab-cefet-main` (ou outra pasta qualquer).
3. Clique no menu **Iniciar (logo do Windows)**, digite `Prompt de Comando`, clique em **"Executar como Administrador"** e confirme para abrir o terminal.
4. Execute `cd C:\lab-cefet-main` e então `install`.


### Forma 3: Instalando todos os programas com um único bat

> Indicada para o Laboratório, em que há limitações no CMD para chamadas de outros .bat.

1. Baixe [lab-cefet-main.zip](https://github.com/thiagodp/lab-cefet/archive/refs/heads/main.zip).
2. Extraia `lab-cefet-main.zip` para `C:\lab-cefet-main` (ou outra pasta qualquer).
3. Clique no menu **Iniciar (logo do Windows)**, digite `Prompt de Comando`, clique em **"Executar como Administrador"** e confirme para abrir o terminal.
4. Execute `cd C:\lab-cefet-main`.
5. Execute `gen` (que irá gerar o lab.bat) e então `lab`.


## Estrutura de diretórios

```
C:\
  |- dev\             <-- Diretório criado para programas para desenvolvimento
  |- ops\             <-- Diretório criado para programas de infraestrutura
  +- Program Files\   <-- Diretório utilizado para programas de escritório e outros
```

## Programas instalados por cada arquivo .bat

### [`install-web.bat`](install-web.bat)

> Instala cada programa em `C:\dev`.

- cURL
- Git
- PHP
- Apache
- Composer
- PHPMyAdmin - em `C:\dev\apache\Apache24\htdocs\phpmyadmin`
- MariaDB - inclui MySQL; usuário `root` e senha `root`
- NodeJS
- Bun
- Putty
- Scrcpy
- PNPM

#### 💡 Observações:
- Desinstala XAMPP, se instalado.
- Já integra o Apache ao PHP, usando [apache-php](https://github.com/thiagodp/apache-php).
- Instala o Apache como serviço e o inicia.
- Instala o MariaDB como serviço e o inicia.
- Configura a senha `root` para o usuário `root` no MariaDB.


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
- Microsoft VCRedist (para o Oracle Virtual Box)
- Oracle VirtualBox


### [`install-python.bat`](install-python.bat)

> Instala cada programa em `C:\dev`.

- Python
- Anaconda


### [`install-other.bat`](install-other.bat)

> Instala cada programa em `C:\dev`.

- MySQL Workbench


### [`install.bat`](install.bat)

- Todos os programas dos `.bat` listados acima.


## Feedback

- Se foi útil pra você, considere dar uma estrela. ⭐
- Para melhorias ou sugestões, [abra um chamado](https://github.com/thiagodp/lab-cefet/issues/new).

## Licença

MIT ©️ [Thiago Delgado Pinto](https://github.com/thiagodp)