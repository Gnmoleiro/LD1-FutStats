import React, { useState, useRef, useEffect, useMemo, memo } from 'react';
import { View, Text, StyleSheet, Animated, TouchableOpacity, FlatList, Modal } from 'react-native';

const CustomDropdown = memo(({ 
  style,
  label,
  placeholder,
  error,
  value = '',
  options = [],
  onSelect,
}) => {
  const [isFocused, setIsFocused] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  // Armazenamos o objeto completo selecionado
  const [selectedValue, setSelectedValue] = useState(value);
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

  const handleSelect = (item) => {
    setSelectedValue(item);
    onSelect && onSelect(item); // passa o objeto completo para o componente chamador
    setIsOpen(false);
    setIsFocused(false);
  };

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
    setIsFocused(!isOpen);
  };

  return (
    <View style={[styles.container, style]}>
      <Animated.Text 
        style={[
          styles.label, 
          labelTransform, 
          { color: labelColor }
        ]}
      >
      </Animated.Text>
      
      <TouchableOpacity 
        style={[styles.input, { borderColor: isFocused ? '#ffffff' : '#666' }]} 
        onPress={toggleDropdown}
      >
        <Text style={[styles.selectedText, { color: inputColor }]}>
          {selectedValue ? selectedValue.label : placeholder}
        </Text>
        <Text style={styles.dropdownIcon}>▼</Text>
      </TouchableOpacity>

      {error && <Text style={styles.errorText}>{error}</Text>}

      <Modal
        visible={isOpen}
        transparent
        animationType="fade"
        onRequestClose={() => setIsOpen(false)}
      >
        <TouchableOpacity 
          style={styles.modalOverlay} 
          activeOpacity={1} 
          onPress={() => setIsOpen(false)}
        >
          <View style={styles.dropdownContainer}>
            <FlatList
              data={options}
              keyExtractor={(item) => item.value.toString()}
              renderItem={({ item }) => (
                <TouchableOpacity 
                  style={styles.optionItem} 
                  onPress={() => handleSelect(item)}
                >
                  <Text style={styles.optionText}>{item.label}</Text>
                </TouchableOpacity>
              )}
            />
          </View>
        </TouchableOpacity>
      </Modal>
    </View>
  );
});

const styles = StyleSheet.create({
  container: {
    marginBottom: 20,
    position: 'relative',
  },
  label: {
    position: 'absolute',
    left: 0,
    top: 0,
    fontSize: 16,
    fontWeight: '400',
    zIndex: 1,
  },
  input: {
    height: 50,
    borderBottomWidth: 1,
    paddingHorizontal: 0,
    paddingTop: 15,
    paddingBottom: 0,
    fontSize: 16,
    color: '#ffffff',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  selectedText: {
    fontSize: 16,
    color: '#ffffff',
  },
  dropdownIcon: {
    fontSize: 14,
    color: '#ffffff',
  },
  errorText: {
    color: '#ff4444',
    fontSize: 12,
    marginTop: 5,
  },
  modalOverlay: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  dropdownContainer: {
    backgroundColor: '#333',
    borderRadius: 5,
    width: '35%',
    maxHeight: 300,
    padding: 10,
    borderWidth: 1,
    borderColor: '#666',
  },
  optionItem: {
    padding: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#444',
  },
  optionText: {
    fontSize: 16,
    color: '#ffffff',
  },
});


export default CustomDropdown;
