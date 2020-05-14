<script>
  export default {
    name: 'modal',
    methods: {
      close() {
        this.$emit('close');
      },
    },
  };
</script>
<template>
  <transition name="modal-fade">
    <div class="modal-backdrop">
      <div class="modal"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <section
          class="modal-body"
          id="modalDescription"
        >
          <slot name="body">
           <center><b class="head">Are you Sure?</b>
            <p class="description">Reconfiguring will reset Tardigrade S3 Gateway. Your information here will be removed, but this will not delete data already backed up to Tardigrade.</p>
           </center>
          </slot>
        </section>
        <footer class="modal-footer">
          <slot name="footer">
            <button type="button" class="btn-cancel" @click="close"aria-label="Close modal">Cancel</button>
            <router-link to="/wizard" class="btn-yes">Yes, Reconfigure</router-link>
          </slot>
        </footer>
      </div>
    </div>
  </transition>
</template>
<style>
  .modal-backdrop {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .modal {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    flex-direction: column;
    width: 40%;
  }

  .modal-header,
  .modal-footer {
    padding: 15px;
    display: flex;
  }

  .modal-header {
    border-bottom: 1px solid #eeeeee;
    color: #4AAE9B;
    justify-content: space-between;
  }

  .modal-footer {
    border-top: 1px solid #eeeeee;
    justify-content: space-evenly;
  }

  .modal-body {
    position: relative;
    padding: 20px 10px;
  }

  .btn-close {
    border: none;
    font-size: 20px;
    padding: 20px;
    cursor: pointer;
    font-weight: bold;
    color: #4AAE9B;
    background: transparent;
  }

  .btn-cancel {
    background: #FFF;
    border: 2px solid blue;
    border-radius: 2px;
    width: 250px;
    padding: 10px;
    color: blue;
    cursor: pointer;
  }

  .btn-yes {
    color: white;
    background: blue;
    border: 2px solid blue;
    border-radius: 2px;
    width: 250px;
    padding: 10px;
    text-align: center;
    margin-left: 10px;
  }

  .head{
    font-size: 18px;
    color: black;
    font-weight: 700;
  }

  .description{
    width: 73%;
    margin-top: 10px;
    color: #585757;
  }
</style>