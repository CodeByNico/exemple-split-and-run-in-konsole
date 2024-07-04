#!/bin/bash

# Définir les commandes à exécuter
cmd1="cd ./backend && poetry run uvicorn app.api.main:app"
cmd2="cd ./webapp && npm run dev"

# Créer le fichier de disposition JSON pour diviser Konsole en deux panneaux verticaux
echo '{
    "Orientation": "Vertical",
    "Widgets": [
        {
            "SessionRestoreId": 0
        },
        {
            "SessionRestoreId": 0
        }
    ]
}' > /tmp/KonsoleSplitLayout.json

# Ouvrir Konsole avec la disposition définie
konsole --layout /tmp/KonsoleSplitLayout.json &
sleep 2

# Obtenir l'identifiant du service Konsole
service="$(qdbus | grep -B1 konsole | grep -v -- -- | sort -t"." -k2 -n | tail -n 1)"

# Exécuter les commandes dans les panneaux
qdbus $service /Sessions/1 org.kde.konsole.Session.runCommand "${cmd1}"
qdbus $service /Sessions/2 org.kde.konsole.Session.runCommand "${cmd2}"
