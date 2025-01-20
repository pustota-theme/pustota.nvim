import React, {
  useState,
  useEffect,
  createContext,
  useContext,
  FC,
  ReactNode,
  MouseEvent,
  ForwardedRef
} from 'react';

/* --------------------------------------------------------------------------
 * Type Declarations
 * -------------------------------------------------------------------------- */

// Enum
enum ThemeMode {
  LIGHT = 'light',
  DARK = 'dark',
}

// Union Type
type Variant = 'primary' | 'secondary' | 'danger';

// Interface with optional property
interface User {
  id: number;
  name: string;
  email?: string; // Optional property
}

interface ThemeContextProps {
  mode: ThemeMode;
  toggleTheme: () => void;
}

// Interface for component props
interface GreetingProps {
  name: string;
}

/* --------------------------------------------------------------------------
 * Theme Context
 * -------------------------------------------------------------------------- */

const ThemeContext = createContext<ThemeContextProps>({
  mode: ThemeMode.LIGHT,
  // placeholder function
  toggleTheme: () => {},
});

/* --------------------------------------------------------------------------
 * Class Component
 * -------------------------------------------------------------------------- */

class GreetingClass extends React.Component<GreetingProps> {
  // Default props using Partial
  public static defaultProps: Partial<GreetingProps> = {
    name: 'DefaultName',
  };

  componentDidMount() {
    console.log('GreetingClass mounted');
  }

  render() {
    return <h2>Hello from Class, {this.props.name}!</h2>;
  }
}

/* --------------------------------------------------------------------------
 * Functional Components
 * -------------------------------------------------------------------------- */

interface AppProps {
  initialMode?: ThemeMode;
  children?: ReactNode;
}

const App: FC<AppProps> = ({ initialMode = ThemeMode.LIGHT, children }) => {
  // Basic state
  const [themeMode, setThemeMode] = useState<ThemeMode>(initialMode);
  const [count, setCount] = useState<number>(0);
  const [users, setUsers] = useState<User[]>([]);

  // Effect hook
  useEffect(() => {
    console.log('App mounted or updated');
  }, [themeMode, count]);

  const handleToggleTheme = () => {
    setThemeMode((prevMode) =>
      prevMode === ThemeMode.LIGHT ? ThemeMode.DARK : ThemeMode.LIGHT
    );
  };

  // Typed event
  const handleButtonClick = (event: MouseEvent<HTMLButtonElement>) => {
    console.log('Button clicked:', event.currentTarget);
    setCount((prevCount) => prevCount + 1);
  };

  // Simulating an async function to fetch users
  async function fetchUsers(): Promise<User[]> {
    // Fake fetch
    return [
      { id: 1, name: 'Alice' },
      { id: 2, name: 'Bob', email: 'bob@example.com' },
    ];
  }

  // Load user data
  useEffect(() => {
    fetchUsers().then((fetchedUsers) => {
      setUsers(fetchedUsers);
    });
  }, []);

  // Context value
  const themeContextValue: ThemeContextProps = {
    mode: themeMode,
    toggleTheme: handleToggleTheme,
  };

  return (
    <ThemeContext.Provider value={themeContextValue}>
      <div
        style={{
          backgroundColor:
            themeMode === ThemeMode.LIGHT ? '#fff' : '#333',
          color: themeMode === ThemeMode.LIGHT ? '#000' : '#fff',
          padding: '1rem',
        }}
      >
        <h1>Testing TSX Syntax in Neovim</h1>
        <GreetingClass name="Neovim User" />
        <p>Current theme mode: {themeMode}</p>
        <button onClick={handleToggleTheme}>Toggle Theme</button>
        <button onClick={handleButtonClick}>Click Count: {count}</button>

        <h3>Current Users:</h3>
        <ul>
          {users.map((user) => (
            <li key={user.id}>
              {user.name}
              {user.email && ` (${user.email})`}
            </li>
          ))}
        </ul>
        {children}
      </div>
    </ThemeContext.Provider>
  );
};

/* --------------------------------------------------------------------------
 * Custom Hook (Generic)
 * -------------------------------------------------------------------------- */

// Generic hook working with any array type
function useArrayState<T>(
  initial: T[]
): [T[], (newItem: T) => void, (index: number) => void] {
  const [array, setArray] = useState<T[]>(initial);

  const pushItem = (newItem: T) => {
    setArray((prev) => [...prev, newItem]);
  };

  const removeItem = (index: number) => {
    setArray((prev) => prev.filter((_, i) => i !== index));
  };

  return [array, pushItem, removeItem];
}

/* --------------------------------------------------------------------------
 * Consumer Component
 * -------------------------------------------------------------------------- */

const ThemeConsumerComponent: FC = () => {
  const { mode, toggleTheme } = useContext(ThemeContext);

  return (
    <div style={{ marginTop: '1rem' }}>
      <p>The current theme is: {mode}</p>
      <button onClick={toggleTheme}>Toggle from consumer</button>
    </div>
  );
};

/* --------------------------------------------------------------------------
 * Generics Utility
 * -------------------------------------------------------------------------- */

// Merge two objects into one typed object
function mergeObjects<A, B>(objA: A, objB: B): A & B {
  return { ...objA, ...objB };
}

/* Example usage:
const merged = mergeObjects({ a: 1 }, { b: "text" });
*/

/* --------------------------------------------------------------------------
 * ForwardRef Example
 * -------------------------------------------------------------------------- */

interface InputProps {
  placeholder?: string;
}

const FancyInput = React.forwardRef(
  (props: InputProps, ref: ForwardedRef<HTMLInputElement>) => {
    return <input ref={ref} placeholder={props.placeholder} />;
  }
);

/* --------------------------------------------------------------------------
 * Exports
 * -------------------------------------------------------------------------- */

export default App;
export {
  GreetingClass,
  ThemeContext,
  ThemeConsumerComponent,
  useArrayState,
  mergeObjects,
  FancyInput,
  ThemeMode,
  Variant,
};
