Vue.use(VueMaterial)

var App = new Vue({
    el: '#app',
    data : function() {
        return {
            email: "",
            ps: [],
            saveFailed: false,
        };
    },
    created : function () {
        this.getps();
    },
    methods: {
        getps: function() {
            let that = this;
            fetch('/api/list', {
                method: 'get'
            }).then(function(response) {
                return response.json()
            }).then(function(r) {
                that.ps = r;
                return r
            }).catch(function(err) {
                console.log(err)
            });
        },
        save: function() {
            let that = this;

            fetch('/api/save?email=' + that.email, {
                method: 'post',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            }).then(function(response) {
                if (response.ok === false) {
                    that.saveFailed = true;
                } else {
                    that.ps.push(that.email);
                    that.saveFailed = false;
                }
                that.email = "";
            }).catch(function(err) {
                console.log(err);
            });
        }
    }
})
