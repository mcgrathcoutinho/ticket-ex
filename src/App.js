import { Dashboard } from "./Dashboard";
import CreateEvent from './mint.js'
import './App.css';

function App() {
  return (
    <div className="App">
      <CreateEvent/>
      <header className="App-header">
        <Dashboard/>
      </header>
    </div>
  );
}

export default App;
