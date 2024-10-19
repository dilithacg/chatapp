import firebase from 'firebase/app';
import 'firebase/firestore';

const db = firebase.firestore();

export async function sendMessage(message) {
    try {
        await db.collection('messages').add(message);
        console.log('Message sent successfully!');
    } catch (error) {
        console.error('Error sending message:', error);
    }
}