# Use a imagem oficial do SonarQube
FROM sonarqube:lts-community

# Adicione o comando para executar as operações como root
USER root

# # Instale o Java JDK
# RUN apt-get update && apt-get install -y openjdk-17-jdk

# Instale o curl e o unzip
RUN apt-get update && apt-get install -y curl unzip

# Baixe e instale o Sonar Scanner
#RUN curl -o /tmp/sonar-scanner.zip -L "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-x64.zip" && \
RUN curl -o /tmp/sonar-scanner.zip -L "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-aarch64.zip" && \
unzip /tmp/sonar-scanner.zip -d /opt && \
rm /tmp/sonar-scanner.zip && \
mv /opt/sonar-scanner-6.1.0.4477-linux-aarch64 /opt/sonar-scanner && \
ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner
#mv /opt/sonar-scanner-6.1.0.4477-linux /opt/sonar-scanner && \

# # Copie o arquivo ZIP para o container
# COPY ./sonar-scanner-cli-6.1.0.4477-linux-x64.zip /tmp/

# # Descompacte o arquivo no diretório /opt e remova o arquivo ZIP
# RUN unzip /tmp/sonar-scanner-cli-6.1.0.4477-linux-x64.zip -d /opt && \
#     rm /tmp/sonar-scanner-cli-6.1.0.4477-linux-x64.zip

# # Renomeie o diretório para algo mais genérico para facilitar o uso
# RUN mv /opt/sonar-scanner-6.1.0.4477-linux-x64 /opt/sonar-scanner

# # Crie um link simbólico para o executável do sonar-scanner em /usr/bin
# RUN ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner

# Configure o Sonar Scanner
ENV SONAR_RUNNER_HOME=/opt/sonar-scanner
ENV PATH=$PATH:/opt/sonar-scanner/bin

# Configuração adicional, se necessário
# Exemplo: Copiar arquivos de configuração personalizados
# COPY sonar-scanner.properties /opt/sonar-scanner/conf/

# Verifique se o grupo sonarqube já existe; se não, crie-o
RUN getent group sonarqube || addgroup --system sonarqube

# Verifique se o usuário sonarqube já existe; se não, crie-o
RUN id -u sonarqube &>/dev/null || adduser --system --no-create-home --ingroup sonarqube sonarqube
USER sonarqube
# Exponha a porta padrão do SonarQube
EXPOSE 9000

# Comando para iniciar o SonarQube
#CMD ["bin/run.sh", "-Dsonar.log.console=true"]
#CMD ["/opt/sonarqube/bin/linux-x86-64/run.sh", "-Dsonar.log.console=true"]
# Adicione qualquer outra configuração necessária
