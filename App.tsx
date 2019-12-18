import React from "react";
import styled from "styled-components/native";

const View = styled.View`
  flex: 1;
  background-color: black;
  align-items: center;
  justify-content: center;
`;

const Text = styled.Text`
  color: white;
`;

export default function App() {
  return (
    <View>
      <Text>Open up App.tsx to start working on your app!</Text>
    </View>
  );
}
