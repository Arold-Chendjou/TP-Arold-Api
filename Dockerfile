# Utiliser l'image alpine comme base qui est une petite distribution Linux
FROM node:alpine AS build

# Definir le répertoire de travail. Les instructions suivantes seront exécutées à cet endroit.
WORKDIR /

# Installer redocly CLI pour générer la documentation
RUN npm install -g @redocly/cli

# Copier le fichier openAPI.yaml dans l'image
COPY ./openAPI.yaml .


# Generer la documentation HTML a partir du fichier openAPI.yaml
RUN redocly build-docs openAPI.yaml --output index.html

# Hoster le fichier html genere
FROM nginx
COPY --from=build index.html /usr/share/nginx/html


EXPOSE 80