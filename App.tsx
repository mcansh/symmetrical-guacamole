import React from "react";
import { Text, View } from "react-native";
import styled from "styled-components/native";

const MyView = styled.View`
  flex: 1;
  background-color: black;
  align-items: center;
  justify-content: center;
`;

const MyText = styled.Text`
  color: white;
`;

export default function App() {
  return (
    <MyView>
      <MyText>Open up App.tsx to start working on your app!</MyText>
    </MyView>
  );
}
