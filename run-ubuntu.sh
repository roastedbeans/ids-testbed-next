#!/bin/bash

# Install dependencies for all projects
cd certification-authority-next && npm install && cd ..
cd information-provider-next && npm install && cd ..
cd mydata-operator-next && npm install && cd ..

# Run each project in a separate terminal
# Terminal 1 - Certification Authority
gnome-terminal --title="Certification Authority" --working-directory="$(pwd)/certification-authority-next" -- bash -c "npm run dev; exec bash"

# Terminal 2 - Information Provider
gnome-terminal --title="Information Provider" --working-directory="$(pwd)/information-provider-next" -- bash -c "npm run dev; exec bash"

# Terminal 3 - MyData Operator
gnome-terminal --title="MyData Operator" --working-directory="$(pwd)/mydata-operator-next" -- bash -c "npm run dev; exec bash"

echo "All projects started in separate terminal windows!" 