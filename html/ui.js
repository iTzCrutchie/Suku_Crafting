/*
    Copyright C 2019  Tim Maia (Carlos A.)
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

function CloseShop() {
    $("#wrapper").html('');
	$("#shopmenu").hide();
    $.post('http://suku_crafting/CloseMenu', JSON.stringify({}));
}

$(document).keyup(function(e) {
     if (e.key === "Escape") {
        CloseShop()
    }
});

$(document).ready(function(){

    var page = 1;
    var mpage = 0;

    $(".card-body").on('click', ':button', function () {
        $("#wrapper").html('');
        $("#shopmenu").hide();
        $.post('http://suku_crafting/CraftSchematic', JSON.stringify({id: $(this).data('id')}));
    });

    $("#close").click(function() {
        CloseShop()
    });

    window.addEventListener('message', function(event) {
        var data = event.data;

        if (data.show) {
            let apage = 1;
            $("#shopmenu").show();
            for (var i = 0; i < data.schematics.length; i++) {
                mpage = data.schematics.length;

                var ingredient = "";
                for (var j = 0; j < data.schematics[i].ingredients.length; j++) {
                    ingredient += "<li>" +data.schematics[i].ingredients[j].name + " x" + +data.schematics[i].ingredients[j].amount + "</li>";
                }
                var Ingredients = "Ingredients:"
                var row = 0;
                
                $("#wrapper").append(`
                                <div id="page">
                                    <div class="row">
                                        <div class="col">
                                            <div class="card" style="border: 3px solid rgba(0, 0, 0, 1); background-image: url(\img/blueprint.jpg\)">
                                                <div class="card-body"><button type="button" id="action1" data-id="`+ i +`" class="btn-btn-light-btn-lg-btn-block">Craft</button>
                                                    <h5 class="card-title">`+data.schematics[i].label+`</h5>
                                                    <p class="card-ingredients" style="border: 2px solid rgba(0, 0, 0, 1);"><font color="#ffffff">`+Ingredients + ingredient+`</font></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>`);
                            if (apage !== page) {
                                $("#page-" + apage).hide();
                            }
                            row++;
                        
            }
        }  
    });
});
