# tf-rna-atac
Clustering transcription factors based on expression and chromatin openness

Interaction of transcription factors and chromatin openness is the driver of cell-type differentiation and cell-state transition. Open chromatin shows what TFs are expected, but such TFs are not always available. Correlation of transcription factors and openness may show insights in such processes, and provide us with potential target to induce cell-state transition.

Clustering is necessary for studying large ammount of TFs. We use a greedy algorithm to find clusters of TFs that share high correlation with each other. The computational complexity is n^2, which is good enough for only thousands of known TFs.

Two examples are shown [here](https://kchen-lab.github.io/tf-rna-atac/notebooks/clustering.nb.html).
