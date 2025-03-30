# Kit de Sobrevivência
> 
> Este documento descreve o processo de instalação dos aplicativos necessários para a realização das atividades propostas no curso de DevOps.
> 

## :one: PowerShell

Abra o `prompt` de comando em mo do **administrador** e executa o seguinte comando:

```powershell
winget install --id Microsoft.Powershell --source winget
```
Para verificar a versão instalada utilize:

```powershell
pwsh --version
```
```
PowerShell 7.4.7
```

A partir deste ponto é necessário que os comandos sejam executados pelo `PowerShell` como **administrador**.

## :two: Windows Terminal

**Instalando**:
```powershell
choco install microsoft-windows-terminal
```

**Iniciando**

```powershell
wt
```

**Verifique a versão do Windows Terminal**:

```powershell
wt --version
```

## :three: WSL2

```powershell
wsl --install
wsl --list --online
```

```
Veja a seguir uma lista de distribuições válidas que podem ser instaladas.
Instale usando 'wsl.exe --install <Distro>'.

NAME                            FRIENDLY NAME
AlmaLinux-8                     AlmaLinux OS 8
AlmaLinux-9                     AlmaLinux OS 9
AlmaLinux-Kitten-10             AlmaLinux OS Kitten 10
Debian                          Debian GNU/Linux
SUSE-Linux-Enterprise-15-SP5    SUSE Linux Enterprise 15 SP5
SUSE-Linux-Enterprise-15-SP6    SUSE Linux Enterprise 15 SP6
Ubuntu                          Ubuntu
Ubuntu-24.04                    Ubuntu 24.04 LTS
kali-linux                      Kali Linux Rolling
openSUSE-Tumbleweed             openSUSE Tumbleweed
openSUSE-Leap-15.6              openSUSE Leap 15.6
Ubuntu-18.04                    Ubuntu 18.04 LTS
Ubuntu-20.04                    Ubuntu 20.04 LTS
Ubuntu-22.04                    Ubuntu 22.04 LTS
OracleLinux_7_9                 Oracle Linux 7.9
OracleLinux_8_7                 Oracle Linux 8.7
OracleLinux_9_1                 Oracle Linux 9.1
```

Verifique a versão do `WSL`:
```powershell
wsl -l -v
```

```text
  NAME              STATE           VERSION
* Ubuntu            Running         2
  Debian            Stopped         2
  docker-desktop    Stopped         2
  Ubuntu-22.04      Stopped         2
```

## Imagem ubuntu no WSL2

```powershell
wsl --install -d Ubuntu-22.04
```

```
wsl: Usando registro de distribuição herdado. Considere usar uma distribuição baseada em tar.
Instalando: Ubuntu 22.04 LTS
Ubuntu 22.04 LTS já foi instalado.
Iniciando Ubuntu 22.04 LTS...
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
For more information visit: https://aka.ms/wslusers
```

Quando a distribuição for iniciada pela primeira vez é necessário informar o `login` e a `senha do usuário`
```
Enter new UNIX username: luisrodrigoog
New password:
Retype new password:
passwd: password updated successfully
Installation successful!
```


Em seguida a distribuição será carregada e o usuário terá acesso ao `terminal` do Linux

```

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.167.4-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Mar 30 10:27:45 -03 2025

  System load:  0.32                Processes:             59
  Usage of /:   0.1% of 1006.85GB   Users logged in:       0
  Memory usage: 9%                  IPv4 address for eth0: 172.26.49.202
  Swap usage:   0%


This message is shown once a day. To disable it please create the
/home/luisrodrigoog/.hushlogin file.
```

Verificando se a distribuição instalada e o seu status:
```powershell
exit
wsl --list --verbose
```

```
  NAME              STATE           VERSION
* Ubuntu            Running         2
  Debian            Stopped         2
  docker-desktop    Running         2
  Ubuntu-22.04      Running         2
```


## Instalando o Chocolaty

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

## Instalando o GIT

```powershell
choco install git -y
git --version
```

## Git-Flow
```powershell
choco install gitflow-avh 
```

## GitHub Desktop

```powershell
choco install github-desktop
```

## virtualbox

```powershell
choco install virtualbox -y
vboxmanage --version
```
## Visual Studio Code

```powershell
choco install vscode
code
```

## Terraform

```powershell
choco install terraform
terraform -v
```

## AWS CLI

```powershell
choco install awscli
aws -v
```

## Notepad++

```powershell
choco install notepadplusplus
```

## Docker

```powershell
choco install docker-cli
choco install docker-desktop
docker --version
docker run hello-world
```


## kubectl

### kubectl (Kubernetes CLI)


```powershell
choco install kubernetes-cli
```

### Minikube

O Minikube permite rodar Kubernetes localmente

```powershell
choco install minikube
```

### Verificar a Instalação

**Verifique a versão do `kubectl`**:
   ```powershell
   kubectl version --client
   ```

**Verifique a versão do Minikube**:
   ```powershell
   minikube version
   ```

### Iniciar um Cluster Local com Minikube

1. **Inicie o Minikube**:
   ```powershell
   minikube start
   ```

2. **Verifique os nós do cluster**:
   ```powershell
   kubectl get nodes
   ```


## Dicas sobre o chocolatey

### Geral

Por padrão os arquivos temporário do chocolatey são armazenados no diretórios

```powershell
C:\Users\luisrodrigoog\AppData\Local\Temp\chocolatey
```

Os programas instalados pelo `Chocolatey` geralmente são armazenados no diretório padrão de instalação de programas do `Windows`, que é:

```plaintext
C:\ProgramData\chocolatey
```

Dentro desse diretório, você encontrará subdiretórios para cada pacote instalado, contendo os arquivos necessários para cada aplicação.

Para manter o Chocolatey e as aplicações instaladas por ele atualizadas, você pode seguir os passos abaixo:

### Atualizar o Chocolatey

1. **Abra o PowerShell como administrador**.
2. **Execute o comando**:
   ```powershell
   choco upgrade chocolatey
   ```

### Atualizar Aplicações Instaladas pelo Chocolatey

1. **Abra o PowerShell como administrador**.
2. **Execute o comando** para atualizar todas as aplicações instaladas:
   ```powershell
   choco upgrade all
   ```

### Agendar Atualizações Automáticas

Para automatizar o processo de atualização, você pode criar uma tarefa agendada no Windows:

1. **Abra o Agendador de Tarefas**.
2. **Crie uma nova tarefa**:
   - Nome: Atualização Chocolatey
   - Descrição: Atualiza o Chocolatey e todas as aplicações instaladas.
3. **Configure o gatilho**:
   - Defina a frequência (diária, semanal, etc.).
4. **Configure a ação**:
   - Ação: Iniciar um programa.
   - Programa/script: `powershell.exe`
   - Adicionar argumentos: `-Command "choco upgrade all -y"`

### Verificar Atualizações Manualmente

Você também pode verificar manualmente se há atualizações disponíveis para pacotes específicos:

1. **Verifique se há atualizações**:
   ```powershell
   choco outdated
   ```

2. **Atualize pacotes específicos**:
   ```powershell
   choco upgrade <nome_do_pacote>
   ```

---
