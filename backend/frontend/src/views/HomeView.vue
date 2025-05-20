<script setup>
import Content from '@/components/Content.vue';
</script>

<template>
  <div>
    <Content>
      <div class="page-container">
        <h1>Wilkommen auf der Simple Cook Home Page</h1>
        <p>Deine neue Rezepte-Verwaltungssoftware. Erkunde unsere leckeren Beispiel-Rezepte. Endecke Rezepte wie:</p>
        
        <div class="recipe-container">
          <div class="image-container">
            <img src="/Pasta.jpeg" alt="Pasta vonogole" class="responsive-image">
          </div>
          <div class="recipe">
            <h2>Pasta vonogole</h2>
            <p><strong>Zutaten:</strong></p>
            <ul>
              <li>400g Spaghetti</li>
              <li>500g Venusmuscheln</li>
              <li>4 Knoblauchzehen</li>
              <li>1/2 Tasse Weißwein</li>
              <li>Olivenöl, Petersilie, Salz, Pfeffer</li>
            </ul>
            <p><strong>Zubereitung:</strong></p>
            <ol>
              <li>Muscheln säubern, Pasta kochen.</li>
              <li>Knoblauch in Olivenöl anbraten, Muscheln und Weißwein hinzufügen.</li>
              <li>5-7 Minuten köcheln, bis Muscheln sich öffnen.</li>
              <li>Pasta hinzufügen, mit Petersilie garnieren.</li>
            </ol>
          </div>
        </div>

        <div class="recipe-container reverse">
          <div class="image-container">
            <img src="/Kuchen.jpg" alt="Schokoladenkuchen" class="responsive-image">
          </div>
          <div class="recipe">
            <h2>Schokoladenkuchen</h2>
            <p><strong>Zutaten:</strong></p>
            <ul>
              <li>200g dunkle Schokolade</li>
              <li>200g Butter</li>
              <li>200g Zucker</li>
              <li>4 Eier</li>
              <li>100g Mehl</li>
              <li>1 Päckchen Backpulver</li>
              <li>1 Prise Salz</li>
            </ul>
            <p><strong>Zubereitung:</strong></p>
            <ol>
              <li>Schokolade und Butter im Wasserbad schmelzen.</li>
              <li>Zucker und Eier in einer Schüssel schaumig schlagen.</li>
              <li>Geschmolzene Schokolade unter die Eier-Zucker-Mischung heben.</li>
              <li>Mehl, Backpulver und Salz sieben und unterheben.</li>
              <li>Teig in eine gefettete Kuchenform füllen und bei 180°C ca. 30 Minuten backen.</li>
              <li>Abkühlen lassen und servieren.</li>
            </ol>
          </div>
        </div>
      </div>
    </Content>
  </div>
</template>

<style scoped>
@import '../assets/typography-styles.css';

.page-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.recipe-container {
  display: flex;
  align-items: flex-start;
  margin-bottom: 40px;
  gap: 40px;
}

.recipe-container.reverse {
  flex-direction: row-reverse;
}

.image-container {
  border: 8px solid #D99014;
  padding: 10px;
  flex-shrink: 0;
}

.responsive-image {
  max-width: 400px;
  height: auto;
  display: block;
}

.recipe {
  flex: 1;
  text-align: left;
}

ul, ol {
  margin: 10px 0;
  padding-left: 20px;
}

li {
  margin-bottom: 5px;
}

h1, h2 {
  text-align: center;
}

h2 {
  margin-top: 0;
}
</style>>
