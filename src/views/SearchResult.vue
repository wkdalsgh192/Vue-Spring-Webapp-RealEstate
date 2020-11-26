<template>
    <div>
        <map-component></map-component>
        <sub-header></sub-header>
    </div>
</template>

<script>

import SubHeader from '@/components/SubHeader.vue';
import MapComponent from '../components/MapComponent';
export default {
    components : {
        MapComponent,
        SubHeader,
    }
}
</script>

<style>

</style>