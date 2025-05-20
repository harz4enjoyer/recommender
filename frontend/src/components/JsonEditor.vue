<script setup>
import { ref, onMounted } from 'vue';
import * as monaco from 'monaco-editor';

const editorContainer = ref(null);
let editorInstance = null;
const jsonData = ref('');

// Use environment variable or fallback for API URL
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

const loadJson = async () => {
  try {
    const response = await fetch(`${API_URL}/json`);
    const data = await response.json();
    jsonData.value = JSON.stringify(data, null, 2);
  } catch (error) {
    console.error('Error loading JSON file:', error);
    jsonData.value = '{\n  "key": "value"\n}';
  }
};

const saveJson = async () => {
  try {
    jsonData.value = editorInstance.getValue();

    // Validate JSON before saving
    JSON.parse(jsonData.value); // This will throw if invalid JSON

    const response = await fetch(`${API_URL}/json`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData.value,
      credentials: 'include'
    });

    if (!response.ok) {
      throw new Error('Server response was not ok');
    }

    const result = await response.json();
    alert('File saved successfully!');
  } catch (error) {
    console.error('Error saving file:', error);
    alert(error instanceof SyntaxError ? 'Invalid JSON format!' : 'Error saving file!');
  }
};

onMounted(async () => {
  await loadJson();
  editorInstance = monaco.editor.create(editorContainer.value, {
    value: jsonData.value,
    language: 'json',
    theme: 'vs-dark',
    automaticLayout: true
  });
});
</script>

<template>
  <div>
    <div ref="editorContainer" style="height: 900px;"></div>
    <button @click="saveJson">Save JSON</button>
  </div>
</template>
