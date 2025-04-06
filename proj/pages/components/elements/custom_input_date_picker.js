import React, { useState, useRef, useEffect, useMemo } from "react";
import { View, Text, TouchableOpacity, StyleSheet, Platform, Animated } from "react-native";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import "./datepicker-custom.css";
import DateTimePickerModal from "react-native-modal-datetime-picker";

const DataInput = ({ placeholder, value, onChangeText, error, style }) => {
  const [isDatePickerVisible, setDatePickerVisibility] = useState(false);
  const [selectedDate, setSelectedDate] = useState(value ? new Date(value) : null);
  const [isFocused, setIsFocused] = useState(false);
  const animatedValue = useRef(new Animated.Value(value ? 1 : 0)).current;

  useEffect(() => {
    Animated.timing(animatedValue, {
      toValue: (isFocused || value) ? 1 : 0,
      duration: 150,
      useNativeDriver: true
    }).start();
  }, [isFocused, value, animatedValue]);

  const showDatePicker = () => {
    setIsFocused(true);
    setDatePickerVisibility(true);
  };
  
  const hideDatePicker = () => {
    setIsFocused(false);
    setDatePickerVisibility(false);
    if (!selectedDate) onChangeText?.("");
  };

  const handleConfirm = (date) => {
    if (date) {
      setSelectedDate(date);
      onChangeText?.(formatDateToDDMMYYYY(date));
    }
    hideDatePicker();
  };

  const isWeb = Platform.OS === 'web';

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

      {isWeb ? (
        <View style={styles.webPickerContainer}>
          <DatePicker
            selected={selectedDate}
            onChange={handleConfirm}
            onBlur={hideDatePicker}
            onFocus={showDatePicker}
            dateFormat="dd/MM/yyyy"
            maxDate={new Date()}
            showYearDropdown
            scrollableYearDropdown
            yearDropdownItemNumber={100}
            className="react-datepicker-custom"
            placeholderText="--/--/----"
            popperClassName="date-picker-popper"
            calendarClassName="date-picker-calendar"
            customInput={
              <TouchableOpacity 
                style={[styles.inputContainer, style]} 
                onPress={showDatePicker}
                activeOpacity={0.8}
              >
                <Text style={[styles.dateText, { color: inputColor }]}>
                  {selectedDate 
                    ? formatDateToDDMMYYYY(selectedDate) 
                    : (isFocused ? "--/--/----" : "")}
                </Text>
              </TouchableOpacity>
            }
          />
        </View>
      ) : (
        <>
          <TouchableOpacity 
            style={[styles.inputContainer, style, error && styles.errorInput]} 
            onPress={showDatePicker}
            activeOpacity={0.8}
          >
            <Text style={[styles.dateText, { color: inputColor }]}>
              {selectedDate 
                ? formatDateToDDMMYYYY(selectedDate) 
                : (isFocused ? "--/--/----" : "")}
            </Text>
          </TouchableOpacity>

          <DateTimePickerModal
            isVisible={isDatePickerVisible}
            mode="date"
            display="default"
            onConfirm={handleConfirm}
            onCancel={hideDatePicker}
            maximumDate={new Date()}
          />
        </>
      )}

      <View style={underlineStyle} />
      {error && <Text style={styles.errorText}>{error}</Text>}
    </View>
  );
};

const formatDateToDDMMYYYY = (date) => {
  if (!date) return "";
  try {
    return date.toLocaleDateString("pt-BR");
  } catch (error) {
    console.error("Erro ao formatar data:", error);
    return "";
  }
};

const styles = StyleSheet.create({
  container: {
    width: "100%",
    marginVertical: 12,
    paddingTop: 18,
    position: 'relative',
  },
  placeholderLabel: {
    fontSize: 20,
    paddingHorizontal: 2,
    position: "absolute",
    left: 5,
    zIndex: 2,
    backgroundColor: "transparent",
    pointerEvents: 'none',
  },
  inputContainer: {
    height: 45,
    justifyContent: 'flex-end',
    paddingBottom: 5,
    marginHorizontal: 5,
  },
  dateText: { 
    fontSize: 16,
    paddingTop: Platform.select({ web: 8, default: 0 }),
    minHeight: 24,
  },
  errorText: { 
    color: "#ff4444", 
    fontSize: 12, 
    marginTop: 4 
  },
  webPickerContainer: {
    position: "relative",
    width: "100%",
    zIndex: 1,
  },
  underline: {
    height: 1,
    backgroundColor: "#666",
    marginTop: 0,
  },
  focusedUnderline: {
    backgroundColor: "#ffffff",
  },
  errorInput: {
    borderColor: "#ff4444",
  },
  errorUnderline: {
    backgroundColor: "#ff4444",
  },
});

export default DataInput;