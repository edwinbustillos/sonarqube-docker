# SonarQube com Sonar Scanner para Java

Este projeto fornece um contêiner Docker que configura o SonarQube com o Sonar Scanner para análise de projetos Java.

## Pré-requisitos

- Docker instalado no seu sistema
- (Opcional) Homebrew para instalar Java e Sonar Scanner no macOS

## Construindo a Imagem Docker

Para construir a imagem Docker, siga os passos abaixo:

1. Clone este repositório:
   ```sh
   git clone <URL_DO_REPOSITORIO>
   cd <NOME_DO_REPOSITORIO>

2. Construa a imagem Docker:

```
docker build --no-cache -t my-sonarqube:latest .

```

3. Executando o Contêiner
Depois de construir a imagem, você pode executar o contêiner usando o comando abaixo:
```
docker run -d --name sonarqube -p 9000:9000 sonarqube-sonar-scanner:latest
```
## 4. Configure e execute o Sonar Scanner:
### macOS

Instale o Sonar Scanner:
```
brew install sonar-scanner
```

Navegue até o diretório do seu projeto e execute:
```
sonar-scanner \
  -Dsonar.projectKey=myproject \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<seu_token_do_sonar>

```
Certifique-se de substituir <seu_token_do_sonar> pelo seu token de autenticação do SonarQube.

### Windows
Configure o Sonar Scanner:

- Adicione o caminho C:\sonar-scanner\bin à variável de ambiente PATH.
Configure e execute o Sonar Scanner:

-  Abra o Prompt de Comando, navegue até o diretório do seu projeto e execute:
```
sonar-scanner \
  -Dsonar.projectKey=myproject \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<seu_token_do_sonar>

```
### Linux
Baixe e instale o Sonar Scanner:
```
curl -o /tmp/sonar-scanner.zip -L "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip"
sudo unzip /tmp/sonar-scanner.zip -d /opt
sudo mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner

```
Configure e execute o Sonar Scanner
 
Navegue até o diretório do seu projeto e execute:
```
sonar-scanner \
  -Dsonar.projectKey=myproject \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<seu_token_do_sonar>

```

## 5. Personalização
Você pode personalizar a configuração do Sonar Scanner copiando ar--quivos de configuração personalizados para o diretório /opt/sonar-scanner/conf/ dentro do contêiner Docker.

Exemplo:
```
# No Dockerfile
COPY sonar-scanner.properties /opt/sonar-scanner/conf/

```