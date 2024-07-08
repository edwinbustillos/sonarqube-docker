# Use a imagem oficial do SonarQube
FROM sonarqube:lts-community

# Adicione o comando para executar as operações como root
USER root

# Instale o Java JDK
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Instale o curl e o unzip
RUN apt-get update && apt-get install -y curl unzip

# Baixe e instale o Sonar Scanner
RUN curl -o /tmp/sonar-scanner.zip -L "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip" && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    rm /tmp/sonar-scanner.zip && \
    mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner

# Configure o Sonar Scanner
ENV SONAR_RUNNER_HOME=/opt/sonar-scanner
ENV PATH=$PATH:/opt/sonar-scanner/bin

# Configuração adicional, se necessário
# Exemplo: Copiar arquivos de configuração personalizados
# COPY sonar-scanner.properties /opt/sonar-scanner/conf/

# Exponha a porta padrão do SonarQube
EXPOSE 9000

# Comando para iniciar o SonarQube
CMD ["bin/run.sh", "-Dsonar.log.console=true"]

# Adicione qualquer outra configuração necessária
