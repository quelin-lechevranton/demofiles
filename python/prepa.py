import numpy as np
import matplotlib.pyplot as plt

# 1 NUMPY ET PYPLOT

M=np.array([[1,2,3],[4,5,6],[7,8,9]], dtype=float)

n=len(M)        # nombre de ligne
n=len(M[0])     # nombre de colonne
n=np.size(M)    # nombre d'élément

M=np.arange(0,1001,1)			# un r		stop exclus , pas
M=np.linspace(0,1000,1001)		# sans e	stop inclus , longueur
M=np.zeros((3,4))				# taille : 3 x 4	type : float
M=np.eye(3)						# indentité
M=np.diag([1,3],1)				# [[0,1,0],[0,0,3],[0,0,0]]

# M[debut : stop(exclus) : pas]
# M[:,j] = colonne j
# M[[i,j,k]] = array des éléments d'indices i , j et k
# M[[i,j],[k,l]] = array des éléments d'indices i,j et k,l

# M = N				py/np=simple vue (ie. même address mémoire ?)
# M = N[:][:]		py/np=simple vue
# M = [ [ N[k][l] for l in range (len(N[0])) ] for k in range (len(N)) ]
# M = np.copy(N)

# + : py=concatenation , np=addition membre à membre : M + 3 = M + 3 * np.ones((...)) 
# np.concatenate(M1,...,Mn) peu optimizé
# * : itération de + (eg. py: [0]*3 = [0,0,0] , (0,)*3 = (0,0,0))
# + * - / ** < > == != : np=array des résultats des opérations membre à menbre


# https://matplotlib.org/api/pyplot_api.html

plt.figure('graphe de la vitesse')				# crée une nouvelle fenêtre
plt.title('Graphe de la vitesse')
plt.text(1.6 , 1.1 , '$v=\sin(t)$' , fontsize=12 , va='center' , ha='center')
plt.axis("equal")								# repère normé (visuellement) ; "off" 
plt.xlabel('temps en $s$')
plt.ylabel('vitesse en $km\cdot h^{-1}$')
# plt.xlim(-1.,6.)								# réécrit plt.axis
# plt.ylim(0.,2.)								# le graphe est toujours affiché en entier
plt.grid()

t=np.linspace(0,4,51)
v=np.sin(t)

plt.plot(t , v , 'k-s' , label='Vitesse')

# color, linestyle, marker ...
# https://matplotlib.org/3.1.0/gallery/

# plt.savefig('vitesse.pdf')
plt.legend( loc='lower left')
plt.show()


#==========================================================================================================

# 2 ÉQUATIONS STATIONNAIRES

# On cherche à résoudre f(x)=v d'inconnue x un réel compris entre a et b


# Dichotomie ( O(ln n) )

def Dichotomie (f,a,b,v,epsilon) :
	while b-a > epsilon :
		c=(a+b)/2
		if (f(c)-v)*(f(b)-v) >= 0 :  
			b=c
		else :
			a=c
	return (a+b)/2


# Méthode d'Newton-Raphson ( O(1) ou presque... )

def Newton1 (f,df,x0,v,epsilon) :			# précision sur l'axe des abscisses
	x1 = x0 - (f(x0) / df(x0))
	while abs (x1 - x0) > epsilon : 
		x0 , x1 = x1 , x0-(f(x0)/df(x0))
	return x0


def Newton2 (f,df,x0,v,epsilon) :			# précision sur l'axe des ordonnées
	while abs (f(x0)) > epsilon : 
		x0 = x0 - (f(x0) / df(x0))
	return x0


def Newton3 (f,df,x0,v,epsilon,nmax=20) :	# Newton est instable si df n'est pas faible
	while abs (f(x0)) > epsilon and nmax : 
		x0 = x0 - (f(x0) / df(x0))
		nmax -= 1
	if nmax > 0 : return x0    
	else : return "erreur"


# Méthode de la sécante (HP) 

# ( f(b)-f(a) ) / ( b-a ) * ( c-a ) + f(a) = 0

def Sécante (f,a,b,v,epsilon) :
	while b-a > epsilon :
		c = ( b*f(a) - a*f(b) ) / ( f(a) - f(b) )
		if (f(c)-v)*(f(b)-v) >= 0 :  
			b=c
		else :
			a=c
	return (a+b)/2


#==========================================================================================================

# 3 INTÉGRATION NUMÉRIQUE

# On cherche à calculer : ∫f sur un segment [a,b]


# Méthode des rectangles : précision = 1/n (si m=0 ou m=1) 1/n² (si m=0.5)

def Rectangle (f,a,b,n,m=0) :
	s = 0
	h = (b-a) / n
	for k in range (n) :
		s += f(a + (m+k) * h)
	return (h * s) 


def npRectangle (f,a,b,n,m=0) :
	h = (b-a) / n
	x = np.arange( a+m*h , b+m*h , h )
	return ( h * np.sum(f(x)) )


# Méthode des trapèzes : précision = 1/n² 

def Trapeze (f,a,b,n) :
	s = (f(a) + f(b)) / 2
	h = (b-a) / n
	for k in range (1,n) :
		s += f(a + k * h)
	return (h * s)

def npTrapeze (f,a,b,n) :
	h = (b-a) / n
	x = np.arange( a+h , b , h )
	return (h * (np.sum(f(x)) + (f(a)+f(b)) / 2 ))


# scipy.integrate.quad

from scipy.integrate import quad

# ∫f = quad(f,a,b)


#==========================================================================================================

# 4 ÉQUATIONS DIFFÉRENTIELLES

# On cherche à résoudre : y'(x)=f(y,x) sachant y(a)=v	d'inconnue y une fonction réelle
#						  								pour x compris entre a et b

# Méthode d'Euler explicite


# Premier ordre à une inconnue

def Euler (f,a,b,v,n=100) :
	h = (b-a) / n
	x = [a+k*h for k in range (n+1)]
	y = [v]
	for k in range (n) :
		y.append(h * f(y[k],x[k]) + y[k])			# y[k] = y[-1] = y(x[k])
	return y

def npEuler (f,a,b,v,n=100) :
	h = (b-a) / n
	x = np.linspace(a , b , n)
	y = np.zeros(n+1)
	y[0] = v
	for k in range (n) : 
		y[k+1] = y[k] + h * f(y[k],x[k])
	return y


# Premier ordre à deux inconnue

		# On cherche à résoudre y'(x)=f(y,z,x) ; z'(x)=g(y,z,x) ; y(a)=v ; z(a)=w 
		# On définit u[k]=[y[k],z[k]]		(u est de taille = n x 2)

		# def h (uk,x) :
		# 	y = uk[0]
		# 	z = uk[1]
		# 	return ([f(y,z,x),g(y,z,x)]) 

		# u = Euler1 (h,a,b,[v,w],n)		(ne fonctionne pas avec npEuler1 en l'état actuel)
		# 										il faut changer : y = np.zeros((n+1,2))			


# Second ordre

		# On cherche à résoudre : y"(x)=f(y',y,x) ; y(a)=v ; y'(a)=w
		# On définit u[k]=[y[k],y'[k]]		(u est de tailler = n x 2)

		# def g (uk,x) :
		# 	y = uk[0]
		# 	dy = uk[1]
		# 	return (dy,f(dy,y,x)) 

		# u = Euler1 (g,a,b,[v,w],n)		(ne fonctionne pas avec npEuler1 en l'état actuel)
		# 										il faut changer : y = np.zeros((n+1,2))		


# scipy.integrate.odeint

from scipy.integrate import odeint

# f(y,x)=y' ; y(a)=v ; t=np.linspace(a,b,n+1)
# y' = odeint(f,v,t)


#==========================================================================================================

# 5 PROBLÈME DISCRET MULTIDIMENSIONEL LINÉAIRE

# On chercher à résoudre un système linéaire de n équations et n inconnues
# On écrit le système sous forme d'une équation matriciel de la forme AX=B d'inconnue X


# Méthode du pivot de Gauß

def Permutation (A,i,j) :
	Li = A[i]					# Li est une vue, c'est pas sensé marcher ¯\_(ツ)_/¯
	A[i] , A[j] = A[j] , Li 
	return None					# facultatif ?

def Dilatation (A,i,m) :
	n = len(A[0])
	for k in range (n) :
		A[i][k] *= m 
	return None	

def Transvection (A,i,j,m) :
	n = len(A[0])
	for k in range (n) :
		A[i][k] += m * A[j][k]
	return None	

def Pivot (A,j) :
	n = len(A)
	i = j
	for k in range (j+1,n) :
		if abs (A[k][j]) > abs (A[i][j]) :
			i = k
	return i

def Gauss (A,B) :
	n = len(A)
	for k in range (n) :
		i = Pivot (A,k)
		if i != k :
			Permutation (A,k,i)
			Permutation (B,k,i)
		m = 1/A[k][k]
		Dilatation (B,k,m)
		Dilatation (A,k,m)
		for l in range (n) :
			if k != l :
				m = -A[l][k]
				Transvection (B,l,k,m)
				Transvection (A,l,k,m)
	return B

# A=[[1.,2.,3.,4.],
#		[1.,8.,7.,1.],
# 		[0.,4.,7.,3.],
# 		[1.,7.,-14.,12.]]
# B=[[1.0], [0.0], [0.0], [0.0]]
# X=[[0.8086070215175539],
# 		[-0.15855039637599094],
# 		[0.053227633069082674],
# 		[0.08720271800679501]]

def npPermutation (A,i,j) :
	Li = np.copy(A[i])
	A[i] , A[j] = A[j] , Li
	return None

def npDilatation (A,i,m) :
	A[i] *= m
	return None 

def npTransvection (A,i,j,m) :
	A[i] += m*A[j]
	return None

def npPivot (A,j) :
	n = len(A)
	Aabs = np.abs( np.copy(A) )
	m = Aabs[j,j]
	i = j
	for k in range (j+1,n) :
		Akj = Aabs[k,j]
		if Akj > m :
			m = Akj
			i = k
	return i

def npGauss (A1,B) :
	n = len(A1)
	A = np.copy(A1)
	for k in range (n) :
		i = npPivot (A,k)
		if i != k :
			npPermutation (A,k,i)
			npPermutation (B,k,i)
		m = 1/A[k][k]
		npDilatation (B,k,m)
		npDilatation (A,k,m)
		for l in range (n) :
			if k != l :
				m = -A[l][k]
				npTransvection (B,l,k,m)
				npTransvection (A,l,k,m)
	return B

# A=np.array([[-.039, .013,   .005,   0.,     0.],
# 		[.013,  -.042,  .017,   .005,   0.],
# 		[.017,  .017,   -.092,  .013,   0.],
# 		[.0,    .005,   .013,   -.042,  .017],
# 		[.0,    .0,     .007,   .017,   -.046]])
# B=np.array([[-.25],
# 		[0.],
# 		[0.],
# 		[0.],
# 		[0.]])
# X=np.array([[7.89972222],
#        [3.57067004],
#        [2.33409123],
#        [1.51844037],
#        [0.91635054]])

#================================================================

# CCS

# import scipy.optimize as opt
# import scipy.integrate as int
# import numpy.linalg as alg
# import numpy.polynomial as poly
# import numpy.random as rd


