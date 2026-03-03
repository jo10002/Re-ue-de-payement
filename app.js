let receiptNumber = "REC-" + Date.now();
document.getElementById("numero").innerText = receiptNumber;
document.getElementById("date").innerText = new Date().toLocaleDateString();

async function generatePDF() {

    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    let nom = document.getElementById("nom").value;
    let montant = document.getElementById("montant").value;
    let motif = document.getElementById("motif").value;
    let mode = document.getElementById("mode").value;

    doc.setFontSize(16);
    doc.text("REÇU", 90, 20);

    doc.setFontSize(12);
    doc.text("Numero: " + receiptNumber, 20, 40);
    doc.text("Date: " + new Date().toLocaleDateString(), 20, 50);
    doc.text("Reçu de: " + nom, 20, 70);
    doc.text("Montant: " + montant + " FCFA", 20, 80);
    doc.text("Pour: " + motif, 20, 90);
    doc.text("Mode de paiement: " + mode, 20, 100);

    doc.text("Signature: ____________________", 20, 130);

    doc.save(receiptNumber + ".pdf");
}



