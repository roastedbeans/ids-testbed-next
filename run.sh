# Install dependencies for all projects
cd certification-authority-next && npm install && cd ..
cd information-provider-next && npm install && cd ..
cd mydata-operator-next && npm install && cd ..

# Run each project in a separate terminal
# Terminal 1 - Certification Authority
osascript -e 'tell app "Terminal" to do script "cd '$(pwd)'/certification-authority-next && npm run dev"'

# Terminal 2 - Information Provider
osascript -e 'tell app "Terminal" to do script "cd '$(pwd)'/information-provider-next && npm run dev"'

# Terminal 3 - MyData Operator
osascript -e 'tell app "Terminal" to do script "cd '$(pwd)'/mydata-operator-next && npm run dev"'
