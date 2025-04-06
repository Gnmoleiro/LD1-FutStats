import React from 'react';
import { Modal, View, Text, TouchableOpacity, StyleSheet, TouchableWithoutFeedback } from 'react-native';
import MaterialCommunityIcons from 'react-native-vector-icons/MaterialCommunityIcons';
import FadeInUpView from '../animacao/FadeInUpView';
import PropTypes from 'prop-types';

const Popup = ({
  visible,
  title,
  message,
  type = 'error',
  actions = [],
  onDismiss,
}) => {
  const getIcon = () => {
    const iconProps = {
      size: 32,
      style: { marginRight: 12 }
    };

    switch (type) {
      case 'error':
        return <MaterialCommunityIcons name="alert-circle-outline" color="#d32f2f" {...iconProps} />;
      case 'warning':
        return <MaterialCommunityIcons name="alert-outline" color="#ed6c02" {...iconProps} />;
      case 'info':
        return <MaterialCommunityIcons name="information-outline" color="#0288d1" {...iconProps} />;
      default:
        return null;
    }
  };

  const getColor = () => {
    switch (type) {
      case 'error':
        return '#d32f2f';
      case 'warning':
        return '#ed6c02';
      case 'info':
        return '#0288d1';
      default:
        return '#d32f2f';
    }
  };

  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onDismiss}>
      <View style={styles.overlay}>
        <TouchableWithoutFeedback onPress={onDismiss}>
          <View style={StyleSheet.absoluteFill} />
        </TouchableWithoutFeedback>

        {/* Correção na posição do FadeInUpView */}
        <FadeInUpView style={styles.animationWrapper}>
          <View style={[styles.container, { borderTopColor: getColor() }]}>
            <View style={styles.header}>
              {getIcon()}
              <Text style={[styles.title, { color: getColor() }]}>{title}</Text>
            </View>

            <Text style={styles.message}>{message}</Text>

            <View style={styles.actions}>
              {actions.map((action, index) => (
                <TouchableOpacity
                  key={index}
                  onPress={action.onPress}
                  style={[
                    styles.button,
                    { borderColor: getColor() },
                    action.style
                  ]}
                  activeOpacity={0.7}>
                  <Text style={[styles.buttonText, { color: getColor() }]}>
                    {action.text}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        </FadeInUpView>
      </View>
    </Modal>
  );
};

Popup.propTypes = {
  visible: PropTypes.bool.isRequired,
  title: PropTypes.string.isRequired,
  message: PropTypes.string.isRequired,
  type: PropTypes.oneOf(['error', 'warning', 'info']),
  actions: PropTypes.arrayOf(
    PropTypes.shape({
      text: PropTypes.string.isRequired,
      onPress: PropTypes.func.isRequired,
      style: PropTypes.object,
    })
  ),
  onDismiss: PropTypes.func,
};

const styles = StyleSheet.create({
  overlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.6)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  animationWrapper: {
    width: '100%',
    alignItems: 'center',
  },
  container: {
    width: '35%', // Ajuste para melhor responsividade
    backgroundColor: 'white',
    borderRadius: 16,
    padding: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 8,
    borderTopWidth: 4,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: '600',
    includeFontPadding: false,
  },
  message: {
    fontSize: 16,
    color: '#424242',
    lineHeight: 24,
    marginBottom: 24,
  },
  actions: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    marginTop: 8,
  },
  button: {
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 8,
    borderWidth: 1,
    marginLeft: 12,
    backgroundColor: 'transparent',
  },
  buttonText: {
    fontSize: 16,
    fontWeight: '500',
  },
});

export default Popup;