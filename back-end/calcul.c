int calcul_depenses() {
    int achats[] = {1200, 800, 450};
    int total = 0;
    for(int i = 0; i < 3; i++) total += achats[i];
    return total;
}
