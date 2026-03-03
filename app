<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WCI DJAGBLE - Receipt</title>

<!-- jsPDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<!-- AutoTable -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

<style>
body{
    font-family: Arial;
    background:#f4f6f9;
    padding:30px;
}
.container{
    background:white;
    padding:20px;
    max-width:500px;
    margin:auto;
    border-radius:8px;
}
input, select{
    width:100%;
    padding:8px;
    margin:6px 0;
}
button{
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    width:100%;
    cursor:pointer;
}
</style>
</head>

<body>

<div class="container">
<h3>WCI DJAGBLE - Receipt Generator</h3>

<label>Name of Depositor</label>
<input type="text" id="name">

<label>Description</label>
<input type="text" id="description">

<label>Purpose of Deposit</label>
<input type="text" id="purpose">

<label>Amount</label>
<input type="number" id="amount">

<label>Payment Mode</label>
<select id="payment">
    <option>Cash</option>
    <option>Bank Transfer</option>
    <option>Mobile Money</option>
    <option>Cheque</option>
</select>

<button onclick="generateReceipt()">Generate PDF (2 per page)</button>
</div>

<script>

function generateReceipt(){

    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    const name = document.getElementById("name").value || "__________";
    const description = document.getElementById("description").value || "__________";
    const purpose = document.getElementById("purpose").value || "__________";
    const amount = document.getElementById("amount").value || "0";
    const payment = document.getElementById("payment").value;

    const date = new Date().toLocaleDateString();
    const receiptNumber = "WCI-" + Date.now();

    let startY = 20;

    for(let i = 0; i < 2; i++){   // This makes TWO receipts on one page

        doc.setFontSize(14);
        doc.text("WCI DJAGBLE", 20, startY);
        doc.text("OFFICIAL PAYMENT RECEIPT", 20, startY + 8);

        const headers = [["Field", "Details"]];
        const data = [
            ["Receipt No", receiptNumber + "-" + (i+1)],
            ["Date", date],
            ["Received From", name],
            ["Description", description],
            ["Purpose", purpose],
            ["Amount", amount + " FCFA"],
            ["Payment Mode", payment],
            ["Authorized Signature", "_____________________"]
        ];

        doc.autoTable({
            startY: startY + 15,
            head: headers,
            body: data,
            theme: "grid",
            styles: { fontSize: 11 }
        });

        startY = doc.lastAutoTable.finalY + 20; // move down for second receipt
    }

    doc.save("WCI_DJAGBLE_Receipt.pdf");
}

</script>

</body>
</html>
