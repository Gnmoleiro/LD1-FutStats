import React, { useRef } from 'react';
import { TouchableOpacity, Text, StyleSheet, Animated, Platform } from 'react-native';

// Cria uma versão animada do TouchableOpacity
const AnimatedTouchable = Animated.createAnimatedComponent(TouchableOpacity);

const SubmitButton = ({ 
  loading, 
  handleSubmit, 
  loadingText = 'Entrando...', 
  defaultText = 'Entrar' 
}) => {
  const scaleAnim = useRef(new Animated.Value(1)).current;

  const handleHoverIn = () => {
    Animated.timing(scaleAnim, {
      toValue: 1.05,
      duration: 200,
      useNativeDriver: true,
    }).start();
  };

  const handleHoverOut = () => {
    Animated.timing(scaleAnim, {
      toValue: 1,
      duration: 200,
      useNativeDriver: true,
    }).start();
  };

  return (
    <AnimatedTouchable 
      style={[
        styles.button, 
        loading && styles.buttonDisabled,
        { transform: [{ scale: scaleAnim }] }
      ]}
      onPress={handleSubmit}
      disabled={loading}
      onMouseEnter={Platform.OS === 'web' ? handleHoverIn : undefined}
      onMouseLeave={Platform.OS === 'web' ? handleHoverOut : undefined}
    >
      <Text style={styles.buttonText}>
        {loading ? loadingText : defaultText}
      </Text>
    </AnimatedTouchable>
  );
};

const styles = StyleSheet.create({
  button: {
    marginTop: 10,
    backgroundColor: '#23722a',
    padding: 10,
    borderRadius: 25,
    alignItems: 'center',
    width: '90%',
    alignSelf: 'center',
  },
  buttonDisabled: {
    backgroundColor: '#1a541f',
    opacity: 0.7,
  },
  buttonText: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default SubmitButton;
