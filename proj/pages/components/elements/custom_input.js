import React, { useState, useRef, useEffect, useMemo, memo } from 'react';
import { View, Text, TextInput, StyleSheet, Animated } from 'react-native';

const CustomInput = memo(({ style,
  label,
  placeholder,
  error,
  value = '',
  onChangeText,
  keyboardType,
  secureTextEntry,
}) => {
  const [isFocused, setIsFocused] = useState(false);
  const animatedValue = useRef(new Animated.Value(value ? 1 : 0)).current;

  useEffect(() => {
    Animated.timing(animatedValue, {
      toValue: (isFocused || value) ? 1 : 0,
      duration: 150,
      useNativeDriver: true
    }).start();
  }, [isFocused, value, animatedValue]);

  const labelTransform = useMemo(() => ({
    transform: [
      { 
        translateY: animatedValue.interpolate({
          inputRange: [0, 1],
          outputRange: [15, -15]
        })
      },
      { 
        scale: animatedValue.interpolate({
          inputRange: [0, 1],
          outputRange: [1, 0.8]
        }) 
      }
    ]
  }), [animatedValue]);

  const labelColor = useMemo(() => 
    error ? '#ff4444' : isFocused ? '#ffffff' : '#666',
  [error, isFocused]);

  const inputColor = useMemo(() => 
    error ? '#ff4444' : '#ffffff',
  [error]);

  const underlineStyle = useMemo(() => [
    styles.underline,
    isFocused && styles.focusedUnderline,
    error && styles.errorUnderline
  ], [isFocused, error]);

  return (
    <View style={styles.container}>
      <Animated.Text 
        style={[
          styles.placeholderLabel,
          labelTransform,
          { color: labelColor }
        ]}
      >
        {placeholder}
      </Animated.Text>
      
      <TextInput
        style={[
          styles.input,
          { color: inputColor },
          error && styles.errorInput,
          style
        ]}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
        onChangeText={onChangeText}
        value={value}
        placeholder=""
        keyboardType={keyboardType}
        secureTextEntry={secureTextEntry}
        accessibilityLabel={`Input para ${placeholder}`}
      />
      
      <View style={underlineStyle} />
      {error && <Text style={styles.errorText}>{error}</Text>}
    </View>
  );
});

const styles = StyleSheet.create({
  container: {
    width: '100%',
    marginVertical: 12,
    paddingTop: 18,
  },
  placeholderLabel: {
    fontSize: 20,
    paddingHorizontal: 2,
    position: 'absolute',
    left: 0,
    zIndex: 1,
    backgroundColor: 'transparent',
  },
  input: {
    height: 45,
    fontSize: 16,
    paddingBottom: 5,
    paddingTop: 8,
    borderBottomWidth: 1,
    borderColor: '#666',
    shadowColor: 'transparent', // Remove sombra
    borderWidth: 0, // Remove borda
    outlineStyle: 'none', // Remove contorno
    marginLeft: 5,
    marginRight: 5,
  },
  underline: {
    height: 1,
    backgroundColor: '#666',
    marginTop: -1,
  },
  focusedUnderline: {
    backgroundColor: '#ffffff', // Cor ao focar no input
  },
  errorInput: {
    borderColor: '#ff4444',
  },
  errorUnderline: {
    backgroundColor: '#ff4444',
  },
  errorText: {
    color: '#ff4444',
    fontSize: 12,
    marginTop: 4,
  },
});

export default CustomInput;
