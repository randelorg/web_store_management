var geval = this.execScript || eval;


function grepperSearch() {
  this.endpoint="https://www.codegrepper.com/api";
  this.acSearchStartValue="";
  this.searchEl=document.getElementById("search");
  this.autocompleteEl=document.getElementById("autocomplete");
  this.relatedTermsEl=document.getElementById("related_searches");
//this.listenForFeedbackOnAnswer = true;
  this.search = getParameterByName("q");
//this.tifgrpr = (getParameterByName("tifgrpr")) ? "&tifgrpr=1" : "";//this is from grpr
//this.user_id=false;
//this.answers=[];
//this.products=[];
//this.doneLoadingAnswersDom=false;
//this.languageGuess="whatever";
//this.isWrittingAnswer=false;
//this.copyClickedTimes=0;
//this.bounty=0;
//this.needsResults1ToDisplayOnDomLoaded=false;
//var currentDate = new Date();
//this.currentTime = currentDate.getTime();
//this.resultsURLS=[];
//this.loadedCodeMirrorModes=[];
//this.moreAnswers=[];
//this.moreResultsInitiated=false;
//this.moreAnswersTotalCount=0;
// //if this get past 15 we have been running for 150 millo seconds and dom has not loaded, something is wrong so finish
//this.stateDomLoadedNoResults=0;
//this.mHasBeenClicked=false;
//this.oHasBeenClicked=false;
this.googleAddsLoaded=false;
}

grepperSearch.prototype.init=function(){
var that=this;

document.addEventListener("click", function(e){
    that.autocompleteEl.style.display="none";
});

document.getElementById("search").addEventListener("keyup", function(e){
    if (e.keyCode === 13) {
        that.grepper_search(this.value);

    }else if(e.keyCode == 37 || e.keyCode == 38 ){
        that.keyUp();
    }else if(e.keyCode == 39 || e.keyCode == 40 ){
        that.keyDown();
    }else{
        that.auto_complete(this.value);
    }
});

if(this.search){
  this.searchEl.value=this.search;
  this.grepper_search(this.search);
}

}

grepperSearch.prototype.auto_complete =function(search){
    if(search.length < 3){
        document.getElementById("autocomplete").style.display="none";
        return;
    }
    abortRequests();
    makeRequest('GET', this.endpoint+"/search_autocomplete.php?q="+search).then(function(data){
            var results=JSON.parse(data);
            this.showAutoCompleteResults(results);
    }.bind(this));
}


grepperSearch.prototype.showAutoCompleteResults=function(results){
    var ac=document.getElementById("autocomplete")
    ac.style.display="block";
    ac.innerHTML="";
    var that =this;
   for(var i=0;i<results.terms.length;i++){
        var acli = document.createElement("li");
            acli.classList.add("autocomplete_li");
            acli.textContent=results.terms[i].term;
            acli.addEventListener("click",function(e){
                document.getElementById("search").value=this.textContent;
                that.grepper_search(this.textContent);
                event.stopPropagation();
                return;
            });
            ac.appendChild(acli);
    }

}

grepperSearch.prototype.keyUp=function(){
    var s=document.getElementById("search");
    var lis = document.getElementById("autocomplete").getElementsByTagName('li');
    var found=false;
   for(var i=0;i<lis.length;i++){
       if(lis[i].classList.contains('autocomplete_selected')){
           lis[i].classList.remove("autocomplete_selected");
           if(i){
            lis[i-1].classList.add("autocomplete_selected");
            s.value=lis[i-1].textContent;
            return;
           }else{
            //lis[lis.length-1].classList.add("autocomplete_selected");
            //s.value=lis[lis.length-1].textContent;
            s.value=this.acSearchStartValue;
            return;
           }
       }
   }
   this.acSearchStartValue=s.value;
   s.value=lis[lis.length-1].textContent;
   lis[lis.length-1].classList.add("autocomplete_selected");
}
grepperSearch.prototype.keyDown=function(){
    var s=document.getElementById("search");
    var lis = document.getElementById("autocomplete").getElementsByTagName('li');
    var found=false;
   for(var i=0;i<lis.length;i++){
       if(lis[i].classList.contains('autocomplete_selected')){
           lis[i].classList.remove("autocomplete_selected");
           if(i<(lis.length-1)){
            lis[i+1].classList.add("autocomplete_selected");
            s.value=lis[i+1].textContent;
            return;
           }else{
            s.value=this.acSearchStartValue;
            return;
           }
       }
   }
   this.acSearchStartValue=s.value;
   s.value=lis[0].textContent;
   lis[0].classList.add("autocomplete_selected");
}

grepperSearch.prototype.displayWidget = function(answer){

    var widget = document.createElement("div");

        widget.classList.add("grepper_widget_holder");
        widget.innerHTML = answer.answer;
        //document.write(answer.answer);
        document.getElementById("search_results").appendChild(widget);

  var m = answer.answer.match(/<script>([\s\S]*?)<\/script>/g);
  if(m){
      var result = m.map(function(val){
         return val.replace(/<\/?script>/g,'');
      });
      result.map(function(val){
          geval(val);
         // eval('function rgbToHex(r, g, b) { return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1); }');
          //console.log(rgbToHex(0,0,0));
      });
  }
        //eval(answer.answer);
}
grepperSearch.prototype.displayResult = function(answer){

        var answer_id=answer.id;

        var codeResults = document.createElement("code");
            codeResults.textContent=answer.answer;
            codeResults.classList.add("commando_code_block");

            var languageGuess="javascript";
            if(answer.language){
                languageGuess=answer.language;
            }
            codeResults.classList.add("language-"+languageGuess);

        var codeResultsPre = document.createElement("pre");
            codeResultsPre.classList.add("language-"+languageGuess);
            codeResultsPre.appendChild(codeResults);
            codeResultsPre.classList.add("commando_selectable");

        var codeResultsOuter = document.createElement("div");
            codeResultsOuter.classList.add("commando_code_block_outer");

         var answerOptionsHolder= document.createElement("div");
             answerOptionsHolder.classList.add("commando_answers_options_holder");


        var answerOptionsTitle= document.createElement("div");
            answerOptionsTitle.classList.add("grepper_answers_options_title");
            //answerOptionsTitle.textContent="“"+answer.term+"”";
            answerOptionsTitle.textContent=answer.term;
            answerOptionsTitle.title=answer.term;


        var answerOptionsNickname= document.createElement("span");
            answerOptionsNickname.classList.add("commando_answers_options_nickname");

            var t = answer.created_at.split(/[- :]/);
            var d = new Date(Date.UTC(t[0], t[1]-1, t[2], t[3], t[4], t[5]));
            var formattedDate=dateToNiceDayString(d);


           var noteHTML= document.createElement("i");

           var userProfileLink= document.createElement("a");
               userProfileLink.target="_blank";
               userProfileLink.href="https://www.codegrepper.com/app/profile.php?id="+answer.user_id;

           var dateOnSpan= document.createElement("i");
               dateOnSpan.textContent = " on "+formattedDate+" ";

               noteHTML.textContent=this.getLanguageFriendlyName(answer.language)+" By ";
               if(this.user_id == answer.user_id){
                 userProfileLink.textContent = "Me ("+jsUcfirst(answer.fun_name)+")";
               }else{
                 userProfileLink.textContent = jsUcfirst(answer.fun_name);
               }

             noteHTML.appendChild(userProfileLink);
             noteHTML.appendChild(dateOnSpan);

            answerOptionsNickname.appendChild(noteHTML);

              if(answer.donate_link){

                    var donateButton= document.createElement("a");
                        donateButton.target="_blank";
                        donateButton.href=answer.donate_link;
                        donateButton.textContent="Donate";

                      //noteHTML+=" <a target='_blank' href='"++"'>Donate</a>";

                answerOptionsNickname.appendChild(donateButton);
              };


            answerOptionsHolder.appendChild(answerOptionsTitle);
            answerOptionsHolder.appendChild(answerOptionsNickname);
                if(parseInt(answer.user_id) === parseInt(this.user_id)){

                    if(localStorage.getItem("grepper_access_token")){
                    var answerOptionsDelete=document.createElement("span");
                        answerOptionsDelete.classList.add("commando_answers_options_delete");
                        answerOptionsDelete.textContent="Delete";
                        answerOptionsDelete.addEventListener('click',function(){
                            this.deleteAnswer(answer.id);
                        }.bind(this));

                          answerOptionsHolder.appendChild(answerOptionsDelete);
                      var answerOptionsEdit=document.createElement("span");
                            answerOptionsEdit.classList.add("commando_answers_options_edit");
                            answerOptionsEdit.textContent="Edit";
                            answerOptionsEdit.addEventListener('click',function(){
                                this.editAnswerStart(answer);
                            }.bind(this));

                        answerOptionsHolder.appendChild(answerOptionsEdit);
                    }

                }

            codeResultsOuter.appendChild(answerOptionsHolder);
            codeResultsOuter.appendChild(codeResultsPre);

        //video
        if(answer.video_name){
            var answerVideo = document.createElement("video");
                answerVideo.setAttribute("controls","");
                answerVideo.classList.add("grepper_answer_video_element_website");
            var answerVideoMP4Source = document.createElement("source");
                answerVideoMP4Source.setAttribute("type", "video/mp4");
                answerVideoMP4Source.setAttribute("src","/video_uploads/"+answer.video_name+".mp4");
            var answerVideoWebMSource = document.createElement("source");
                answerVideoWebMSource.setAttribute("type", "video/webm");
                answerVideoWebMSource.setAttribute("src","/video_uploads/"+answer.video_name+".webm");

                answerVideo.appendChild(answerVideoMP4Source);
                answerVideo.appendChild(answerVideoWebMSource);
                codeResultsOuter.appendChild(answerVideo);
        }
           //source 
          var sourceURLHolder= document.createElement("div");
              sourceURLHolder.setAttribute("id","grepper_source_holder");
              sourceURLHolder.textContent = "Source:"

                var sourceURL= document.createElement("a");
                    sourceURL.target="_blank";
                    sourceURL.href=answer.source_url;
                    sourceURL.textContent = sourceURL.hostname;
                    //noteHTML+=" <a target='_blank' href='"++"'>Donate</a>";

              sourceURLHolder.appendChild(sourceURL);

              //answerOptionsNickname.appendChild(donateButton);

              if(answer.source_url && this.isValidSource(answer.source_url)){
                codeResultsOuter.appendChild(sourceURLHolder);
              }


            //no, voting for now
          var commandoVotingHolder= document.createElement("div");
              commandoVotingHolder.classList.add("commando-voting-holder");
          var upvote= document.createElement("div");
              upvote.classList.add("arrow-up");
              upvote.setAttribute("answer_id",answer.id);
              upvote.addEventListener('click', this.doUpvote.bind(this,event,answer));
              if(answer.i_upvoted == 1){
                upvote.classList.add("commando_voted");
               }



          var voteNumber= document.createElement("div");
              voteNumber.classList.add("commando-voting-number");
              voteNumber.textContent=(answer.upvotes-answer.downvotes);

          var downvote= document.createElement("div");
              downvote.classList.add("arrow-down");

              downvote.addEventListener('click', this.doDownvote.bind(this,event,answer));
              if(answer.i_downvoted == 1){
                downvote.classList.add("commando_voted");
              }




          commandoVotingHolder.appendChild(upvote);
          commandoVotingHolder.appendChild(voteNumber);
          commandoVotingHolder.appendChild(downvote);
          codeResultsOuter.appendChild(commandoVotingHolder);


          answer.downvote=downvote;
          answer.upvote=upvote;
          answer.voteNumber=voteNumber;
          answer.codeResults=codeResults;
          answer.myDom=codeResultsOuter;

        document.getElementById("search_results").appendChild(codeResultsOuter);

}

grepperSearch.prototype.showSearchResults=function(results){
    var answers=results.answers;
    for(let i=0;i<answers.length;i++){
   // if(answers[i].is_widget){
   //     this.displayWidget(answers[i]);
   // }else if(answers[i].is_download){
   //     this.displayDownload(answers[i]);
   // }else{
          this.displayResult(answers[i]);
   //     }
    }
    Prism.highlightAll();
}

grepperSearch.prototype.displayDownload=function(answer){
   

}

grepperSearch.prototype.showRelatedTerms=function(terms){
document.getElementById("related_searches_holder").style.display="block";
     this.relatedTermsEl.innerHTML="";//clear it 
    for(let i=0;i<terms.related_terms.length;i++){
    var t = document.createElement("a");
        t.textContent=terms.related_terms[i].term;
        t.href="/search.php?q="+terms.related_terms[i].term;
        this.relatedTermsEl.appendChild(t);
    }
}

//if we did not have any results lets provider some suggesetions

grepperSearch.prototype.getSearchTermsAlternatives=function(search){
    makeRequest('GET',"/api/search_term_alternatives.php?q="+search).then(function(data){
            var results=JSON.parse(data);
            this.showRelatedTerms(results);
    }.bind(this));

}


/*
grepperSearch.prototype.getRelatedTerms=function(search){
    makeRequest('GET',"/api/search_related.php?q="+search).then(function(data){
            var results=JSON.parse(data);
            this.showRelatedTerms(results);
    }.bind(this));

}
*/

grepperSearch.prototype.do_grepper_search=function(){
        this.grepper_search(this.searchEl.value);
}

grepperSearch.prototype.grepper_search=function(search){

    if(window.fromBrowse){
        //todo:remove this after we improce
        makeRequest('GET', "/api/page_log.php?action=searched");
        document.location="/search.php?q="+search;
        return;
    }

     document.title="Search Code Snippets | "+search;

     window.history.replaceState('', '', updateURLParameter(window.location.href, "q", search));


     document.getElementById("no_results_holder").style.display="none";
     document.getElementById("search_results").innerHTML='';

    var url= "/api/search.php?q="+search;
    var ls = document.getElementsByName("search_options");
    if(ls.length){
        var search_options = [];
        for(let i =0;i<ls.length;i++){
            if(ls[i].checked){
                search_options.push(ls[i].value);
            }
        }
        if(search_options.length){
            url+="&search_options="+search_options.join(",");
        }else{
            url+="&search_options=0";
        }
    }

    //we always move to new screen after search
    document.getElementById("search_bar_top_padding").style.display="none";
    document.getElementById("content").classList.add("has_searched");
    document.getElementById("or_browse").style.display="none";
    document.getElementById("or_browse_2").style.display="block";

    document.getElementById("loading_holder").style.display="block";

//  if(!this.googleAddScript){
//     this.googleAddScript = document.createElement('script');
//      this.googleAddScript.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";
//cument.head.appendChild(this.googleAddScript);
//  }

     this.displayGoogleAds();

     makeRequest('GET', url).then(function(data){
     document.getElementById("loading_holder").style.display="none";

            var results=JSON.parse(data);
            if(results.answers.length){
                this.showSearchResults(results);
            }else{
                document.getElementById("no_results_holder").style.display="block";
            }

            this.getSearchTermsAlternatives(search);
    }.bind(this));
     document.getElementById("autocomplete").style.display="none";
     if(document.getElementById("search_page_add_grepper_answer_button")){
        document.getElementById("search_page_add_grepper_answer_button").style.display="block";
    }
}


grepperSearch.prototype.getLanguageFriendlyName =function(l){
    var options=getAllLanguages();
    return options[l].name;
}

grepperSearch.prototype.doUpvote =function(progressEvent,answer,mouseEvent) {
        var mustRegisterPopup= document.getElementById("must_register_popup");
        if(mustRegisterPopup){
            mustRegisterPopup.style.display="block";
            return;
        }

      var currentVal= mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent;

      var postData={};
          postData.id=answer.id;
          postData.term=this.search;
          postData.isRequestedExtraAnswer=answer.isRequestedExtraAnswer;
          postData.isExtraAnswer=answer.isExtraAnswer;
          postData.results = this.resultsURLS;

       if(mouseEvent.target.classList.contains("commando_voted")){
           mouseEvent.target.classList.remove("commando_voted");
           mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)-1);
           makeRequest('POST', "/api/feedback.php?from_web=1&delete=1&vote=1&search_answer_id="+answer.search_answer_id+"&search_answer_result_id="+answer.search_answer_result_id, JSON.stringify(postData)).then(function(data1){
           var data=JSON.parse(data1);
               answer.search_answer_result_id=data.id;
                  if(data.subscription_expired){
                        this.showNeedsPaymentBox(data.subscription_expired_text);
                  }

           }.bind(this));
       }else{
          //add one if other we are not already down
           if(mouseEvent.target.parentElement.getElementsByClassName("arrow-down")[0].classList.contains("commando_voted")){
               mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)+2);
           }else{
               mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)+1);
           };

           mouseEvent.target.classList.add("commando_voted");
           mouseEvent.target.parentElement.getElementsByClassName("arrow-down")[0].classList.remove("commando_voted");
           makeRequest('POST', "/api/feedback.php?from_web=1&vote=1&search_answer_id="+answer.search_answer_id+"&search_answer_result_id="+answer.search_answer_result_id, JSON.stringify(postData)).then(function(data1){

        var data=JSON.parse(data1);
            answer.search_answer_result_id=data.id;
             if(data.subscription_expired){
                this.showNeedsPaymentBox(data.subscription_expired_text);
             }
           }.bind(this));
      }
}

grepperSearch.prototype.doDownvote =function(progressEvent,answer,mouseEvent) {

        var mustRegisterPopup= document.getElementById("must_register_popup");
        if(mustRegisterPopup){
            mustRegisterPopup.style.display="block";
            return;
        }
      var currentVal= mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent;

      var postData={};
          postData.id=answer.id;
          postData.term=this.search;
          postData.isRequestedExtraAnswer=answer.isRequestedExtraAnswer;
          postData.isExtraAnswer=answer.isExtraAnswer;

     if(mouseEvent.target.classList.contains("commando_voted")){
           mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)+1);
           mouseEvent.target.classList.remove("commando_voted");
           makeRequest('POST', "/api/feedback.php?from_web=1&delete=1&vote=4&search_answer_id="+answer.search_answer_id+"&search_answer_result_id="+answer.search_answer_result_id,JSON.stringify(postData)).then(function(data1){

        var data=JSON.parse(data1);
            answer.search_answer_result_id=data.id;
           //not on downvotes
           //if(data.subscription_expired){
           //   this.showNeedsPaymentBox(data.subscription_expired_text);
           //}
           }.bind(this));
       }else{

          //add one if other we are not already down
           if(mouseEvent.target.parentElement.getElementsByClassName("arrow-up")[0].classList.contains("commando_voted")){
               mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)-2);
           }else{
               mouseEvent.target.parentElement.getElementsByClassName("commando-voting-number")[0].textContent=(parseInt(currentVal)-1);
           };
       mouseEvent.target.classList.add("commando_voted");
       mouseEvent.target.parentElement.getElementsByClassName("arrow-up")[0].classList.remove("commando_voted");
       makeRequest('POST', "/api/feedback.php?from_web=1&vote=4&search_answer_id="+answer.search_answer_id+"&search_answer_result_id="+answer.search_answer_result_id,
      JSON.stringify(postData)).then(function(data1){
        var data=JSON.parse(data1);
            answer.search_answer_result_id=data.id;

           //not on downvotes
           //if(data.subscription_expired){
           //   this.showNeedsPaymentBox(data.subscription_expired_text);
           //}
       }.bind(this));
   }
}

grepperSearch.prototype.startsWith=function(str,word){
    return str.lastIndexOf(word, 0) === 0;
}

grepperSearch.prototype.isValidSource=function(str){
  if(!str){return false;}
  if(!this.startsWith(str,"http://") && !this.startsWith(str,"https://")){
        return false;
  }
  var res = str.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
  return (res !== null);
}

grepperSearch.prototype.maxLength=function(str,length){
    return str.length > length ? str.substring(0, length) + "..." : str;
}

grepperSearch.prototype.displayGoogleAds =function(l){
    if(this.googleAddsLoaded){
        return;
    }
    this.googleAddsLoaded = true;
    document.getElementById('google_add_holder_for_search_page_1').innerHTML='<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-4352740086546929" data-ad-slot="8417738428" data-ad-format="auto" data-full-width-responsive="true"></ins>';

 (adsbygoogle = window.adsbygoogle || []).push({});
   document.getElementById('search_horizontal_add1').style.display="block";
    document.getElementById('search_horizontal_add1').innerHTML='<ins class="adsbygoogle" style="display:inline-block;width:728px;height:90px" data-ad-client="ca-pub-4352740086546929" data-ad-slot="2817211743"></ins>'; 

 (adsbygoogle = window.adsbygoogle || []).push({});




 var gaScript = document.createElement('script');
    gaScript.type = 'text/javascript';
    gaScript.src = 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js';
    document.body.appendChild(gaScript);

}



var gs=new grepperSearch();
gs.init();

