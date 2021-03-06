/* form clear */
function clearDefault(el) {
	if (el.defaultValue==el.value) el.value = ""
}

$(function() {
	/* Basic 
	 * mainly by <a href='#' class='boxy'>
	 */
	$(function() {
  		$('.boxy').boxy();
	});

	/* Boxy
	Contact modal boxy
	http://www.varnagiris.net/2009/04/11/ajax-feedback-form-using-jquery-boxy-plugin/
	*/
    /* set global variable for boxy window */
    var contactBoxy = null;
    /* what to do when click on contact us link */
    $('.contact_us').click(function(){
        var boxy_content;
        boxy_content += "<div style=\"width:300px; height:300px\"><form id=\"feedback\">";
        boxy_content += "<p>Subject<br /><input type=\"text\" name=\"subject\" id=\"subject\" size=\"35\" /></p><p>Your email address:<br /><input type=\"text\" name=\"sender\" id=\"sender\" size=\"35\" /></p><p>Comment:<br /><textarea name=\"comment\" id=\"comment\" cols=\"35\" rows=\"8\"></textarea></p><br /><input type=\"submit\" name=\"submit\" value=\"Send >>\" />";
        boxy_content += "</form></div>";
        contactBoxy = new Boxy(boxy_content, {
            title: "Send feedback",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#feedback').submit(function() {
                    Boxy.get(this).setContent("<div style=\"width: 300px; height: 300px; margin: 20px auto;\">Sending...</div>");
                    // submit form by ajax using post and send 3 values: subject, sender, comment
                    //$.post("http://samul.org/main/messenger/email", { subject: c.find("input[name='subject']").val(), sender: c.find("input[name='sender']").val(), comment: c.find("#comment").val()},
                    $.post("/main/messenger/email", { subject: c.find("input[name='subject']").val(), sender: c.find("input[name='sender']").val(), comment: c.find("#comment").val()},
                    function(data){
                        /*set boxy content to data from ajax call back*/
                        contactBoxy.setContent("<div style=\"width: 300px; height: 300px; margin: 20px auto;\">"+data+"</div>");
                    });
                    return false;
                });
            }
        });
        return false;
    });

	/* Boxy searching interface with a prompt dialog 
	 * pdb search
	 */
	var pdbBoxy = null;
	$('.search_pdb').click(function(){
		var boxy_content;
		boxy_content +="<div><h2>Please enter a PDB ID:</h2>";
		boxy_content +="<form id=\"search_pdb\" method=\"get\" action=\"/main/search/pdb\">";
		//boxy_content +="<form id=\"pdb_form\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"13\" value=\"1dan\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form></div>";

		pdbBoxy = new Boxy(boxy_content, {
			title: "Search by PDB",
            draggable: false,
            modal: true,
			/*center: false,fixed: false,*/
            behaviours: function(c) {
                c.find('#search_pdb').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) not working - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"pdb", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	});

	/* Boxy searching interface with a prompt dialog 
	 * uniprot search
	 */
	var uniprotBoxy = null;
	$('.search_uniprot').click(function(){
		var boxy_content;
		boxy_content +="<h2>Please enter a UniProt ID:</h2>";
		boxy_content +="<form id=\"search_uniprot\" method=\"get\" action=\"/main/search/uniprot\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"13\" value=\"O14832\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form>";

		uniprotBoxy = new Boxy(boxy_content, {
			title: "Search by UniProt",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#search_uniprot').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) not working - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"uniprot", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	});

	/* Boxy searching interface with a prompt dialog 
	 * snp search
	 */
	var snpBoxy = null;
	$('.search_snp').click(function(){
		var boxy_content;
		boxy_content +="<h2>Please enter a dbSNP ID:</h2>";
		boxy_content +="<form id=\"search_snp\" method=\"get\" action=\"/main/search/snp\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"13\" value=\"rs3088308\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form>";

		snpBoxy = new Boxy(boxy_content, {
			title: "Search by dbSNP",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#search_snp').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) not working - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"snp", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	});


	/* Boxy searching interface with a prompt dialog 
	 * gene search
	 */
	var geneBoxy = null;
	$('.search_gene').click(function(){
		var boxy_content;
		boxy_content +="<h2>Please enter a gene name:</h2>";
		boxy_content +="<form id=\"search_gene\" method=\"get\" action=\"/main/search/gene\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"20\" value=\"MYC\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form>";

		geneBoxy = new Boxy(boxy_content, {
			title: "Search by a gene name",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#search_gene').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) not working - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"gene", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	});

	/* Boxy searching interface with a prompt dialog 
	 * keyword search
	 */
	var keywordBoxy = null;
	$('.search_keyword').click(function(){
		var boxy_content;
		boxy_content +="<h2>Please enter keywords:</h2>";
		boxy_content +="<form id=\"search_keyword\" method=\"get\" action=\"/main/search/keyword\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"20\" value=\"kinase\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form>";

		keywordBoxy = new Boxy(boxy_content, {
			title: "Search by keywords",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#search_keyword').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) not working - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"keyword", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	});

	/* Boxy searching interface with a prompt dialog 
	 * smiles string search
	 */
	var smileBoxy = null;
	$('.search_smiles').click(function(){
		var boxy_content;
		boxy_content +="<h2>Please enter your SMILES string:</h2>";
		boxy_content +="<form id=\"search_smiles\" method=\"get\" action=\"/main/search/smiles\">";
		boxy_content +="<input type=\"text\" name=\"id\" id=\"id\" size=\"50\" value=\"C([C@@H]1[C@H]([C@@H]([C@H]([C@@H](O1)O)O)O)O)O\" ONFOCUS=\"clearDefault(this)\"/>";
		boxy_content +="<input type=\"submit\" value=\"Go\"/>";
		boxy_content +="</form>";

		keywordBoxy = new Boxy(boxy_content, {
			title: "Search by SMILES string",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#search_keyword').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) NOT WORKING - don't know why. (using 'action' above at the moment)
                    $.get("/main/search/by_ids", { id_type:"id", id:c.find("input[name='id']").val() });
					return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	}); // end of smile

	 /* About (from Menu) 
	var smileBoxy = null;
	$('.about').click(function(){
		var boxy_content;
		boxy_content +="<h2>Hello!</h2>";
		boxy_content +="<p>SAMUL: Systematic Annotations for Macro-molecuLE</p>";
		keywordBoxy = new Boxy(boxy_content, {
			title: "About SAMUL",
            draggable: true,
            modal: false,
            behaviours: function(c) {
                c.find('#about').submit(function() {
                    //Boxy.get(this).setContent("<div><p>Searching.........</p></div>");
                    // submit form by ajax using post and send 1 values: id
					// [debug] url (search/by_ids) NOT WORKING - don't know why. (using 'action' above at the moment)
                    // $.get("/main/search/by_ids", { id_type:"id", id:c.find("input[name='id']").val() });
					// return true;
                }); // end of .submit
            } //end of behaviours
		});
		return true;
	}); // end of about 
	*/
});

/* Tooltip using jQuery Tooltip
 * http://flowplayer.org/tools/tooltip.html
 */

/* plain text tooltip 
 */
$(document).ready(function() { 
    $(".general_list_table a[title]").tooltip({tip: '.plain_tooltip_small', effect: 'fade', fadeOutSpeed: 80}); 

    $(".general_list_table th[title]").tooltip({tip: '.plain_tooltip_small', effect: 'fade', fadeOutSpeed: 80}); 

});
