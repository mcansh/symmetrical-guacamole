import React from 'react';
import styled from 'styled-components/native';
import {
  StatusBar,
  Text,
  StyleSheet,
  Button,
  NativeModules,
  View,
} from 'react-native';
import { iOSUIKit, iOSColors } from 'react-native-typography';

const MyView = styled.View`
  flex: 1;
  background-color: black;
  align-items: center;
  justify-content: center;
  flex: 1;
  justify-content: center;
`;

const styles = StyleSheet.create({
  yellowTitle: {
    color: iOSColors.yellow,
  },
});

const App = () => {
  const getMusic = async () => {
    console.log(NativeModules);
  };

  return (
    <MyView>
      <StatusBar barStyle="light-content" />
      <View>
        <Text style={[iOSUIKit.body, styles.yellowTitle]}>
          Open up App.tsx to start working on your app!
        </Text>
        <View
          style={{
            padding: 10,
            backgroundColor: iOSColors.yellow,
            borderRadius: 8,
            marginTop: 20,
          }}
        >
          <Button
            onPress={getMusic}
            color={iOSColors.white}
            title="Get Music"
          />
        </View>
      </View>
    </MyView>
  );
};

export default App;
