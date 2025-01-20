import React from 'react';
import { useState, useEffect } from 'react';

// Class Component Example
export class MyClassComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0,
    };
  }

  handleIncrement = () => {
    this.setState(prevState => ({ count: prevState.count + 1 }));
  };

  render() {
    const { message, children } = this.props;

    return (
      <div className="my-class-component" style={{ padding: '1rem', border: '1px solid #ccc' }}>
        <h1>{message}</h1>
        <p>Count: {this.state.count}</p>
        <button onClick={this.handleIncrement}>Increment</button>
        <hr />
        <div>{children}</div>
      </div>
    );
  }
}

// Functional Component Example with Hooks
export function MyFunctionalComponent({ items = [], showText }) {
  const [inputValue, setInputValue] = useState('');
  const [highlighted, setHighlighted] = useState(false);

  useEffect(() => {
    console.log('Items or showText changed');
  }, [items, showText]);

  const handleChange = (e) => setInputValue(e.target.value);
  const toggleHighlight = () => setHighlighted(prev => !prev);

  return (
    <>
      <div className={`input-container ${highlighted ? 'highlight' : ''}`}>
        <label htmlFor="myInput">Type something:</label>
        <input
          id="myInput"
          type="text"
          value={inputValue}
          onChange={handleChange}
          style={{ marginLeft: '0.5rem' }}
        />
        <button onClick={toggleHighlight}>Toggle Highlight</button>
      </div>
      <div>
        {showText ? (
          <p>Current Input: {inputValue || 'No input provided yet.'}</p>
        ) : (
          <p>Text display is disabled.</p>
        )}
      </div>
      <ul>
        {items.map((item, index) => (
          <li key={`${item}-${index}`}>{item}</li>
        ))}
      </ul>
    </>
  );
}

// Component Demonstrating Spread Props and dangerouslySetInnerHTML
export function AdvancedFeaturesComponent(props) {
  const { tag, ...rest } = props; // Destructure and spread any extra props

  return (
    <div style={{ marginTop: '1rem' }}>
      <WrappedTag tag={tag} {...rest} />
    </div>
  );
}

function WrappedTag({ tag, content, style }) {
  const CustomTag = tag || 'div';
  const innerHtmlString = '<strong>This is injected HTML!</strong>';

  return (
    <CustomTag
      style={style}
      dangerouslySetInnerHTML={{ __html: content || innerHtmlString }}
    />
  );
}

// Usage Example
export default function TestComponents() {
  const items = ['Apple', 'Banana', 'Cherry'];

  return (
    <div>
      <MyClassComponent message="Hello from Class Component">
        <p style={{ color: 'blue' }}>I am a child prop.</p>
      </MyClassComponent>
      <MyFunctionalComponent items={items} showText={true} />
      <AdvancedFeaturesComponent
        tag="section"
        content="<em>Custom HTML content via props!</em>"
        style={{ color: 'red', backgroundColor: '#f9f9f9' }}
      />
    </div>
  );
}
