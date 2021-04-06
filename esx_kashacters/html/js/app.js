$(".character-box").hover(
    function() {
        $(this).css({
            "background": "rgb(44, 51, 69)",
            "transition": "200ms",
        });
    }, function() {
        $(this).css({
            "background": "rgba(255, 255, 255, 1.0)",
            "transition": "200ms",          
        });
    }
);

$(".character-box").click(function () {
    $(".character-box").removeClass('active-char');
    $(this).addClass('active-char');
    $(".character-buttons").css({"display":"block"});
    if ($(this).attr("data-ischar") === "true") {
        $("#delete").css({"display":"block"});
    } else {
        $("#delete").css({"display":"none"});
    }
});

$("#play-char").click(function () {
    $.post("http://esx_kashacters/CharacterChosen", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
        ischar: $('.active-char').attr("data-ischar"),
    }));
    Kashacter.CloseUI();
});

$("#deletechar").click(function () {
    $.post("http://esx_kashacters/DeleteCharacter", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
    }));
    Kashacter.CloseUI();
});

(() => {
    Kashacter = {};

    Kashacter.ShowUI = function(data) {
        $('.main-container').css({"display":"block"});
        $('.bg').css({"display":"block"});
        if(data.characters !== null) {
            $.each(data.characters, function (index, char) {
                if (char.charid !== 0) {
                    var charid = char.identifier.charAt(4);
                    $('[data-charid=' + charid + ']').html('<h3 class="character-fullname">'+ char.firstname +' '+ char.lastname +'</h3><div class="character-info"><p class="character-info-work"><strong>Job: </strong><span>'+ char.job +'</span></p><p class="character-info-money"><strong>Money: </strong><span>'+ char.money + '$' +'</span></p><p class="character-info-bank"><strong>Bank balance: </strong><span>'+ char.bank + '$' +'</span></p> <p class="character-info-dateofbirth"><strong>Date of birth: </strong><span>'+ char.dateofbirth +'</span></p> <p class="character-info-gender"><strong>Gender: </strong><span>'+ char.sex +'</span></p> <p class="character-info-height"><strong>Heigh: </strong><span>'+ char.height + 'cm' +'</span></p> <p class="character-info-phone-number"><strong>Phone number: </strong><span>'+ char.phone_number   +'</span></p> <p class="character-info-notiz"><strong>Note: </strong><span>'+ char.Notiz   +'</span></p></div>').attr("data-ischar", "true");
                }
            });
        }
    };

    Kashacter.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $('.BG').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $("#delete").css({"display":"none"});
		$(".character-box").html('<h3 class="character-fullname"><i class="fas fa-plus"></i></h3><div class="character-info"><p class="character-info-new">Neuen Charakter erstellen</p></div>').attr("data-ischar", "false");
    };
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    Kashacter.ShowUI(event.data);
                    break;
            }
        })
    }

})();