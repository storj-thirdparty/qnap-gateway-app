<style>
    @import '../resources/css/wizard.css';
    @import 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css';
 </style>
<template>
  <div>
    <router-view></router-view>
    <nav>
    <div class="screen">
      <img src="../resources/img/tardigrade.png" class="tardigrade">
      <span class="spacer"></span>
      <p class="gateway">S3 Gateway</p>

       <a href="config.php" class="home">Home</a>
      <a href="https://documentation.tardigrade.io/api-reference/s3-gateway" target="blank" class="docs">S3 Gateway Docs</a>
      <a href="https://us-central-1.tardigrade.io" class="login" target="blank">Tardigrade Login</a>
    </div>
  </nav>
  </div>
</template>
