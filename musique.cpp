using namespace std;
#include<math.h>
#include<iostream>
#include<fstream>
#include<stdlib.h>
// #include<bibli_fonctions.h> Librairie du magistère



// initialisation des variables globales

double f=44100;			// Hz   frequence d'echantionnage temporelle
double s=100;			// 1/m  frequence d'echantionnage spatiale
double l=1;			// m    longueur de la corde
int N=10;			// 1    nombre d'harmonique calculee
double a=0.1*l;			// m    abscisse de frappe du marteau
double e=0.01;			// m    epaisseur du marteau
double u=2;			// m/s  vitesse du marteau

double tau=0.4;			// s	temps characteristique d'attenuation du son
double delta=0.5;		// l	longueur characteristique d'attenuation du son dans l'air
double va=340;			// m/s 	vitesse du son dans l'air

double bpm=100;			// 1	nombre de battement par minute
int signature=3;		// 1	nombre de temps par mesure
	
int NM=9;			// 1	nombre total de mesure
double T=NM*signature*60/bpm+5;	// s    temps totale de la note

int I=f*T;			// 1	nombre d'echantillons temporels total
int J=s*l;			// 1	nombre d'echantillons spatials


int Iy=f*3*tau;			// 1  	nombre d'echantillons temporels par note

int d=2;			// 1	 nombre d'octet par point 
int nc=2;			// 1	 nombre de canaux

double amp=3*pow(10,1);		// 1	normalisation du signal dans [-1;1]



double* P=(double*)malloc(I*sizeof(double));

// fonction qui ecrit le fichier wave a partir du tableau des pression

void fichier_wave (double* Q) {

	fstream note("bwv885.wav", ios::out);

	note.write("RIFF",4);
				int A=44+I*d*nc-8;
	note.write((char*)&A,4);	
	note.write("WAVE",4);

	note.write("fmt ",4);
				A=16;
	note.write((char*)&A,4) ;	
				A=1;
	note.write((char*)&A,2);	
				A=nc;
	note.write((char*)&A,2);	
				A=f;
	note.write((char*)&A,4);	
				A=d*nc*f;
	note.write((char*)&A,4);	
				A=d*nc;
	note.write((char*)&A,2);	
				A=d*8;
	note.write((char*)&A,2);	

	note.write("data",4) ;
				A=I*d*nc;
	note.write((char*)&A,4) ;	


	short vals;
	double vald;
	for (int i=0 ; i<I ; i++) {
		vald=Q[i]*(pow(2,d*8-1)-1);	
		// cout << vald << endl;
		vals=vald;			// conversion en short
		// cout << val << endl;
		note.write((char*)&vals,d);
		note.write((char*)&vals,d);
	}


	note.close();
}



// fonction qui cree une note

void ajout_note ( int octave , int degree , int mesure , double temps ) {


	// octave : octave de la note
	// degree : note dans l'octave : 1=la ; 2=sib ; 3=si ; 
	// mesure : mesure de la note
	// temps : temps dans la mesure	


	double v = pow(2 , (octave-3.) + (degree-1.)/12. )*440;	
	// vitesse de propagation de l'onde dans la corde = frequence de la note car l=1
	
	double t0 = ( (mesure-1)*signature + (temps-1) )*60/bpm;
	// instant en seconde ou commence la note



	// y(t,x)  est le tableau repertoriant la hauteur de la corde en fonction du temps et de l'espace

	double** y=(double**)malloc(Iy*sizeof(double*));

	for (int i=0 ; i<Iy ; i++) {
		y[i]=(double*)malloc(J*sizeof(double));
	}

	// B est le tableau des coefficient devant chaque harmonique

	double *B=(double*)malloc(N*sizeof(double));

	for( int n=1 ; n<=N ; n++) {
		B[n]=(2*u*e)/(n*M_PI*v)*sin(n*M_PI*a/l);
	}


	// calcule de y pour un piano suivant l'enonce du sujet

	double S;
	
	for (int i=0 ; i<Iy ; i++) {
		for (int j=0 ; j<J ; j++) {
			S=0;
			for (int n=1 ; n<=N ; n++) {
				S+=B[n]*sin(n*M_PI*v*i/f/l)*sin(n*M_PI*j/s/l);
			}
			y[i][j]=S;
		}
	}



	// Pression au centre de la corde (sans propagation dans l'air)
		
	int x0=0.5*J ;	
	int i0=t0*f;
	for (int i=0 ; i<Iy ; i++) {
		P[i+i0]+=y[ i ][x0]*amp*v*exp(-i/f/tau); 
		// cout << P[i]  << endl;
	}
	
	
	// pression via propagation dans l'air	
	/*
	double dist = 2;
	double lambda;
	int k;
	for (int i=0 ; i<I ; i++) {
	      	S=0;
		for (int j=0 ; j<J ; j++) {
			lambda=sqrt(dist*dist+(l/2-j/s)*(l/2-j/s));
			k=lambda/va*exp(-i/s/delta);	
			S+=1/s*y[i-k][j];
		}
		P[i]=S*amp*exp(-i/f/tau);
	}	
	*/

	free(y);
	free(B);

}



int main () {



	//	initialisation du table des pression
	
	
	for (int i=0 ; i<I ; i++) {
		P[i]=0;
	}




	// ajout_note ( 3 , 1 , 1 , 1 );


	// partition du theme de Mario Bross , il faut mettre bpm=180, NM=6 et signature=4 dans l'entete
	/*		
 	ajout_note( 4 , 8 , 1 , 1 );
        ajout_note( 4 , 8 , 1 , 1.5 );
        ajout_note( 4 , 8 , 1 , 2.5 );
        ajout_note( 4 , 4 , 1 , 3.5 );
        ajout_note( 4 , 8 , 1 , 4 );
	
        ajout_note( 4 , 11 , 2 , 1 );
        ajout_note( 3 , 11 , 2 , 3 );
	
        ajout_note( 4 , 4 , 3 , 1 );
        ajout_note( 3 , 11 , 3 , 2.5 );
        ajout_note( 3 , 8 , 3 , 4 );

        ajout_note( 4 , 1 , 4 , 1.5 );
        ajout_note( 4 , 3 , 4 , 2.5 );
        ajout_note( 4 , 2 , 4 , 3.5 );
        ajout_note( 4 , 1 , 4 , 4 );
	
        ajout_note( 3 , 11 , 5 , 1 );
        ajout_note( 4 , 8 , 5 , 1.667 );
        ajout_note( 4 , 11 , 5 , 2.333 );
        ajout_note( 5 , 1 , 5 , 3 );
        ajout_note( 4 , 9 , 5 , 4 );
        ajout_note( 4 , 11 , 5 , 4.5 );
	
        ajout_note( 4 , 8 , 6 , 1.5 );
        ajout_note( 4 , 4 , 6 , 2.5 );
        ajout_note( 4 , 6 , 6 , 3 );
        ajout_note( 4 , 3 , 6 , 3.5 );
	
        ajout_note( 2 , 9 , 1 , 1 );
        ajout_note( 2 , 9 , 1 , 1.5 );
        ajout_note( 2 , 9 , 1 , 2.5 );
        ajout_note( 2 , 9 , 1 , 3.5 );
        ajout_note( 2 , 9 , 1 , 4 );
	
        ajout_note( 2 , 11 , 2 , 1 );
        ajout_note( 1 , 11 , 2 , 3 );

        ajout_note( 2 , 11 , 3 , 1 );
        ajout_note( 2 , 8 , 3 , 2.5 );
        ajout_note( 2 , 4 , 3 , 4 );
	
        ajout_note( 2 , 9 , 4 , 1.5 );
        ajout_note( 2 , 11 , 4 , 2.5 );
        ajout_note( 2 , 10 , 4 , 3.5 );
        ajout_note( 2 , 9 , 4 , 4 );
	
        ajout_note( 2 , 8 , 5 , 1 );
        ajout_note( 3 , 4 , 5 , 1.667 );
        ajout_note( 3 , 8 , 5 , 2.333 );
        ajout_note( 3 , 9 , 5 , 3 );
        ajout_note( 3 , 6 , 5 , 4 );
        ajout_note( 3 , 8 , 5 , 4.5 );
	
        ajout_note( 3 , 4 , 6 , 1.5 );
        ajout_note( 3 , 1 , 6 , 2.5 );
        ajout_note( 3 , 3 , 6 , 3 );
        ajout_note( 2 , 11 , 6 , 3.5 );
      	*/


	// partition d'une fugue de bach (BWV 885) bpm=100 ; NM=9 ; signature = 3
	
	ajout_note( 3 , 6 , 1 , 2 );
	ajout_note( 3 , 2 , 1 , 3.5 );
	
	ajout_note( 3 , 7 , 2 , 1 );
	ajout_note( 3 , 4 , 2 , 2 );
	ajout_note( 3 , 1 , 2 , 3.5 );

	ajout_note( 3 , 6 , 3 , 1 );
	ajout_note( 3 , 2 , 3 , 2 );
	ajout_note( 2 , 11 , 3 , 3.5 );
	
	ajout_note( 3 , 4 , 4 , 1 );
	ajout_note( 3 , 4 , 4 , 1.5 );
	ajout_note( 3 , 4 , 4 , 2 );
	ajout_note( 3 , 4 , 4 , 2.5 );
	ajout_note( 3 , 4 , 4 , 3 );
	ajout_note( 3 , 4 , 4 , 3.5 );
	
	ajout_note( 3 , 4 , 5 , 1 ); 		ajout_note( 3 , 11 , 5 , 2 ); 
	ajout_note( 3 , 2 , 5 , 1.5 ); 		ajout_note( 3 , 6 , 5 , 3 ); 
	ajout_note( 3 , 1 , 5 , 1.75 ); 	ajout_note( 3 , 5 , 5 , 3.25 ); 
	ajout_note( 3 , 2 , 5 , 2 ); 		ajout_note( 3 , 9 , 5 , 3.5 ); 
	ajout_note( 2 , 11 , 5 , 2.25 ); 	ajout_note( 3 , 6 , 5 , 3.3 ); 
	ajout_note( 3 , 2 , 5 , 2.5 );
	ajout_note( 3 , 4 , 5 , 2.75 );
	
	ajout_note( 3 , 6 , 6 , 1 ); 		ajout_note( 4 , 2 , 6 , 1 ); 
	ajout_note( 2 , 11 , 6 , 1.5 ); 	ajout_note( 3 , 11 , 6 , 2 ); 
	ajout_note( 2 , 11 , 6 , 2.25 ); 	ajout_note( 3 , 8 , 6 , 3.5 ); 
	ajout_note( 3 , 1 , 6 , 2.5 );
	ajout_note( 3 , 2 , 6 , 2.75 );
	ajout_note( 3 , 4 , 6 , 3 );
	ajout_note( 3 , 3 , 6 , 3.25 );
	ajout_note( 3 , 4 , 6 , 3.5 );

	ajout_note( 3 , 4 , 7 , 1 ); 		ajout_note( 4 , 1 , 7 , 1 ); 
	ajout_note( 2 , 9 , 7 , 1.5 ); 		ajout_note( 3 , 9 , 7 , 2 ); 
	ajout_note( 2 , 9 , 7 , 2.25 ); 	ajout_note( 3 , 6 , 7 , 3.5 ); 
	ajout_note( 2 , 11 , 7 , 2.5 );
	ajout_note( 3 , 1 , 7 , 2.75 );
	ajout_note( 3 , 2 , 7 , 3 );
	ajout_note( 3 , 1 , 7 , 3.25 );
	ajout_note( 3 , 2 , 7 , 3.5 );

	ajout_note( 3 , 2 , 8 , 1);		ajout_note( 3 , 11 , 8 , 1);
	ajout_note( 3 , 1 , 8 , 1.25);		ajout_note( 3 , 11 , 8 , 1.5);
	ajout_note( 3 , 2 , 8 , 1.5);		ajout_note( 3 , 11 , 8 , 2);
	ajout_note( 3 , 1 , 8 , 1.75);		ajout_note( 3 , 11 , 8 , 2.5);
	ajout_note( 2 , 11 , 8 , 2);		ajout_note( 3 , 11 , 8 , 3);
	ajout_note( 2 , 9 , 8 , 2.25);		ajout_note( 3 , 11 , 8 , 3.5);
	ajout_note( 2 , 11 , 8 , 2.5);
	ajout_note( 2 , 9 , 8 , 2.75);
	ajout_note( 2 , 8 , 8 , 3);
	ajout_note( 2 , 6 , 8 , 3.25);
	ajout_note( 2 , 8 , 8 , 3.5);
	ajout_note( 2 , 6 , 8 , 3.75);

	ajout_note( 2 , 5 , 9 , 1);		ajout_note( 3 , 11 , 9 , 1);
	ajout_note( 3 , 1 , 9 , 1.5);		ajout_note( 3 , 9 , 9 , 1.5);
	ajout_note( 2 , 6 , 9 , 2);		ajout_note( 3 , 8 , 9 , 1.75);
	ajout_note( 3 , 4 , 9 , 2.5);		ajout_note( 4 , 6 , 9 , 2);
	ajout_note( 3 , 2 , 9 , 3);		ajout_note( 3 , 9 , 9 , 2);
	ajout_note( 2 , 11 , 9 , 3.5);		ajout_note( 3 , 6 , 9 , 2.25);
						ajout_note( 3 , 8 , 9 , 2.5);
						ajout_note( 3 , 10 , 9 , 2.75);
						ajout_note( 3 , 11 , 9 , 3);
						ajout_note( 3 , 10 , 9 , 3.25);
						ajout_note( 4 , 2 , 9 , 3.5);
						ajout_note( 3 , 11 , 9 , 3.5);
	





	// Graphe python de la pression en fonction du temps au point d'observation 
	// Utilise la librarie du magistère
	
		
	// fstream fich("pression.dat", ios::out);
	// for (int i=0 ; i<I ; i++) {
	// 	fich << P[i] << " " << i << endl;
	// }
	// fich.close();	
	// ostringstream pyth;
	// pyth
	// 	<< "A=loadtxt('pression.dat')\n"
	// 	<< "x=A[:,1]\n"
	// 	<< "y=A[:,0]\n"
	// 	<< "plot(x,y)\n"
	// 	;
	// make_plot_py(pyth);
	


	fichier_wave (P) ;
	
	return 0;
}

