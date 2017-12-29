## Mining of Massive Datasets
Leskovec J, Rajaraman A and Ullman JD

Part of I0U19A - Management of Large-scale Omics Data

![kuleuven-logo](/images/KULeuven-logo-2012.png)
![stadius-logo](/images/logo_stadius-small.png)
![vda-logo](/images/my_version_transparent.gif)

--NEWH
big data, high dimensional => need to decrease number of points to show (data reduction) and/or number of dimensions (DR)

--NEWH
# Data reduction

--NEWH
## I. Finding similar items

--NEWV
Jaccard similarity of sets

\\(SIM(S,T) = \frac{S \cap T}{S \cup T}\\)

--NEWH
# Dimensionality reduction


--NEWH
## II. Dimensionality reduction

--NEWH
### II.1 Principal Component Analysis PCA

--NEWH
### II.2 Singular Value Decomposition SVD

--NEWV
**Aim**

Extract the general *concepts* from a matrix

--NEWV
**Definition of SVD**

Let \\(M\\) be an \\(m x n\\) matrix of rank \\(r\\) => find matrices \\(U\\), \\(\Sigma\\) and \\(V\\) such that:

* \\(U\\) is an \\(m x r\\) *column-orthonormal matrix* (i.e. each of the columns is a unit vector and the dot product of any two columns is 0)
* \\(V\\) is an \\(n x r\\) column-orthonormal matrix. Rows of \\(V^T\\) are orthonormal.
* \\(\Sigma\\) is a diagnomal matrix. The elements of \\(\Sigma\\) are called the *singular values of M*.

--NEWV
![svd](/images/svd.png)

--NEWV
The data: ratings of movies by users

$$
\tiny
\begin{array}{c c} &
\begin{array}{c c c c c} A & B & C & D & E \\\\
\end{array}
\\\\
\begin{array}{c c c c c c c}
Joe \\\\
Jim \\\\
John \\\\
Jack \\\\
Jill \\\\
Jenny \\\\
Jane
\end{array}
&
\left[
\begin{array}{c c c c c}
1 & 1 & 1 & 0 & 0 \\\
3 & 3 & 3 & 0 & 0 \\\
4 & 4 & 4 & 0 & 0 \\\
5 & 5 & 5 & 0 & 0 \\\
0 & 0 & 0 & 4 & 4 \\\
0 & 0 & 0 & 5 & 5 \\\
0 & 0 & 0 & 2 & 2
\end{array}
\right]
\end{array}
\\\\
\tiny
A = Matrix ; B = Alien ; C = Star Wars ; D = Casablanca ; E = Titanic
$$

--NEWV
$$
\tiny
\begin{pmatrix}
1 & 1 & 1 & 0 & 0 \\\\
3 & 3 & 3 & 0 & 0 \\\\
4 & 4 & 4 & 0 & 0 \\\\
5 & 5 & 5 & 0 & 0 \\\\
0 & 0 & 0 & 4 & 4 \\\\
0 & 0 & 0 & 5 & 5 \\\\
0 & 0 & 0 & 2 & 2
\end{pmatrix}
=
\begin{pmatrix}
0.14 & 0 \\\\
0.42 & 0 \\\\
0.56 & 0 \\\\
0.70 & 0 \\\\
0 & 0.60 \\\\
0 & 0.75 \\\\
0 & 0.30
\end{pmatrix}
\begin{pmatrix}
12.4 & 0 \\\\
0 & 9.5
\end{pmatrix}
\begin{pmatrix}
0.58 & 0.58 & 0.58 & 0 & 0 \\\\
0 & 0 & 0 & 0.71 & 0.71
\end{pmatrix}
$$

$$
M = U \Sigma V^T
$$

--NEWV
**Interpretation**

Concepts hidden in \\(M\\): *science fiction* vs *romance*

* \\(U\\): connects people to concepts, e.g. Joe likes only the concept *science fiction*
* \\(V\\): connects movies to concepts, e.g. Matrix is a *science fiction* movie
* \\(\Sigma\\): strength of each of the concepts

Note:
sigma: science-fiction concept is stronger because the data provides more information about the movies of that genre and the people who like them.

--NEWV
**Dimensionality reduction using SVD**

Imagine not-so-clean distinctions

$$
\tiny
\begin{pmatrix}
1 & 1 & 1 & 0 & 0 \\\\
3 & 3 & 3 & 0 & 0 \\\\
4 & 4 & 4 & 0 & 0 \\\\
5 & 5 & 5 & 0 & 0 \\\\
0 & \textbf{2} & 0 & 4 & 4 \\\\
0 & 0 & 0 & 5 & 5 \\\\
0 & \textbf{1} & 0 & 2 & 2
\end{pmatrix}
=
\begin{pmatrix}
0.13 & 0.02 & -0.01 \\\\
0.41 & 0.07 & -0.03 \\\\
0.55 & 0.09 & -0.04 \\\\
0.68 & 0.11 & -0.05 \\\\
0.15 & -0.59 & 0.65 \\\\
0.07 & -0.73 & -0.67 \\\\
0.07 & -0.29 & 0.32
\end{pmatrix}
\begin{pmatrix}
12.4 & 0 & 0 \\\\
0 & 9.5 & 0 \\\\
0 & 0 & 1.3
\end{pmatrix}
\begin{pmatrix}
0.56 & 0.59 & 0.56 & 0.09 & 0.09 \\\\
0.12 & -0.02 & 0.12 & -0.69 & -0.69 \\\\
0.40 & -0.80 & 0.40 & 0.09 & 0.09
\end{pmatrix}
$$

--NEWV
Set the smallest of the singular values to zero

Rule of thumb: sum of squares of retained singular values should be at least 90% of sum of squares of all the singular values

* Total: \\(12.4^2 + 9.5^2 + 1.3^2 = 245.70\\)
* Removing one singular value: \\(12.4^2 + 9.5^2 = 244.01\\) = 99.3% of total

--NEWV
**Data reduction using SVD**: idem

A picture of a pansy, at a resolution of 465x600

![pansy_full](/images/pansy_full.png)

--NEWV
After running SVD and recombining only the first column of \\(U\\) with the first element of \\(\Sigma\\) and the first row of \\(V^T\\):

![pansy_1](/images/pansy_1.png)

--NEWV
Taking 5 columns from \\(U\\) and rows from \\(V^T\\):

![pansy_5](/images/pansy_5.png)

--NEWV
**Querying using concepts**

E.g. Quincy = new user who only saw Matrix and gave it a score of 4

=> Quincy's vector: \\(q = [4,0,0,0,0]\\)

--NEWV
Q1: *Which other movies would Quincy like? (= recommendation engine)*

* map Quincy into concept space: multiply him by matrix \\(V\\)

\\(qV = [2.32,0]\\) => Quincy is high in science-fiction interest

* map Quincy into movie space: multiply his representation in concept space by \\(V^T\\)

\\(qV x V^T = [1.35,1.35,1.35,0,0]\\) => Quincy would like Alien and Star Wars, but not Casablanca and Titanic


--NEWV
Q2: *Find users similar to Quincy*

* map all users into concept space: multiply them by matrix \\(V\\)

e.g. Joe: \\([1.74,0]\\); Jill: \\([0, 5.68]\\)

* calculate *cosine distance* between Quincy and the others, with <br/>
\\(cosinedistance = \frac{A \cdot B}{\left \\| A \right \\|\left \\| B \right \\|} = 1 - \frac{ax + by + cz}{\sqrt{a^2 + b^2 + c^2} \sqrt{x^2 + y^2 + z^2}}\\)<br/>
for vectors \\(A = [a,b,c]\\) and \\(B = [x,y,z]\\)
    * distance with Joe: 0.75
    * distance with Jill: 1

--NEWV
Running SVD in python

--NEWV
Running SVD on example dataset
```python
a = [[1 , 1 , 1 , 0 , 0],
     [3 , 3 , 3 , 0 , 0],
     [4 , 4 , 4 , 0 , 0],
     [5 , 5 , 5 , 0 , 0],
     [0 , 0 , 0 , 4 , 4],
     [0 , 0 , 0 , 5 , 5],
     [0 , 0 , 0 , 2 , 2]]

U, s, V = np.linalg.svd(a)
U.shape, V.shape, s.shape # Returns 7x5
S = np.zeros((7,5))
S[:5, :5] = np.diag(s)
U,S,V
```

--NEWV
Returns
```python
(array([[-0.14002801,  0.        ,  0.41748286, -0.56011203, -0.42008403,
          0.52185358,  0.20874143],
        [-0.42008403,  0.        ,  0.15383647, -0.20639328,  0.84520504,
          0.19229558,  0.07691823],
        [-0.56011203,  0.        ,  0.20511529,  0.72480896, -0.20639328,
          0.25639411,  0.10255764],
        [-0.70014004,  0.        , -0.33989068, -0.3439888 , -0.2579916 ,
         -0.42486335, -0.16994534],
        [ 0.        , -0.59628479,  0.64444444,  0.        ,  0.        ,
         -0.44444444, -0.17777778],
        [ 0.        , -0.74535599, -0.44444444,  0.        ,  0.        ,
          0.44444444, -0.22222222],
        [ 0.        , -0.2981424 , -0.17777778,  0.        ,  0.        ,
         -0.22222222,  0.91111111]]),
 array([[ 12.36931688,   0.        ,   0.        ,   0.        ,   0.        ],
        [  0.        ,   9.48683298,   0.        ,   0.        ,   0.        ],
        [  0.        ,   0.        ,   0.        ,   0.        ,   0.        ],
        [  0.        ,   0.        ,   0.        ,   0.        ,   0.        ],
        [  0.        ,   0.        ,   0.        ,   0.        ,   0.        ],
        [  0.        ,   0.        ,   0.        ,   0.        ,   0.        ],
        [  0.        ,   0.        ,   0.        ,   0.        ,   0.        ]]),
 array([[-0.57735027, -0.57735027, -0.57735027, -0.        , -0.        ],
        [-0.        , -0.        , -0.        , -0.70710678, -0.70710678],
        [ 0.        ,  0.        ,  0.        , -0.70710678,  0.70710678],
        [ 0.        , -0.70710678,  0.70710678,  0.        ,  0.        ],
        [ 0.81649658, -0.40824829, -0.40824829,  0.        ,  0.        ]]))
```
Only first two columns of \\(U\\) and first two rows of \\(V\\) are relevant because only two non-zero values on diagonal of \\(\Sigma\\).

--NEWV
Advantages SVD:
* best possible projection in terms of reconstruction error

Disadvantages SVD:
* computationally intensive
* results are dense vectors that are big and are hard to interpret

--NEWH
### II.3 CUR Decomposition

* [https://www.youtube.com/watch?v=5_u017ydnAA](https://www.youtube.com/watch?v=5_u017ydnAA)
* [https://www.youtube.com/watch?v=_kD34bgroGM](https://www.youtube.com/watch?v=_kD34bgroGM)

--NEWV
SVD example above: special case with many `0`'s

You'd want \\(U\\), \\(\Sigma\\) and \\(V\\) to be sparse, but they are typically dense.

--NEWV
**C**U**R** replaces the left and right singular vectors in the SVD with actual **c**olumns and **r**ows from the matrix, respectively.

$$
\begin{pmatrix}
& & & & \\\\
& & A & & \\\\
& & & &
\end{pmatrix}
=
\begin{pmatrix}
& & \\\\
& C & \\\\
& &
\end{pmatrix}
\begin{pmatrix}
U
\end{pmatrix}
\begin{pmatrix}
& & R & &
\end{pmatrix}
+
\begin{pmatrix}
& & & & \\\\
& & E & & \\\\
& & & &
\end{pmatrix}
$$

--NEWV

![cur_lesscompressed](/images/cur_lesscompressed.jpeg)

![cur_compressed](/images/cur_compressed.jpeg)

--NEWV
$$
\begin{pmatrix}
& & & & \\\\
& & user-by-movie & & \\\\
& & & &
\end{pmatrix}
\approx
\begin{pmatrix}
& & \\\\
& users & \\\\
& &
\end{pmatrix}
\begin{pmatrix}
U
\end{pmatrix}
\begin{pmatrix}
& & movies & &
\end{pmatrix}
$$

--NEWV
Which columns and rows should be in \\(C\\) and \\(R\\)?

`ColumnSelect` algorithm:

**Input**: matrix \\(\textbf{A} \in \mathbb{R}\\), sample size \\(c\\)<br/>
**Output**: \\(\textbf{C}_d \in \mathbb{R}^{m x c}\\)

1. for \\(x = 1 : n\\) [column distribution]<br/>
1. &nbsp;&nbsp;&nbsp;&nbsp;\\(P(x) = \frac{\sum\_i\textbf{A}(i,x)^2}{\sum\_{i,j}\textbf{A}(i,j)^2}\\)
1. for \\(i = 1 : c\\) [sample columns]
1. &nbsp;&nbsp;&nbsp;&nbsp;Pick \\(j \in 1:n\\) based on distribution \\(P(x)\\)
1. &nbsp;&nbsp;&nbsp;&nbsp;Compute \\(\textbf{C}_d(:,i) = \frac{\textbf{A}(:,j)}{\sqrt{cP(j)}}\\)

--NEWV
Computing \\(U\\):

Let \\(\textbf{W}\\) be the "intersection" of sampled columns \\(\textbf{C}\\) and row \\(\textbf{R}\\), with<br/>
SVD of \\(\textbf{W}\\) equal to \\(\textbf{X} \cdot \textbf{Z} \cdot \textbf{Y}^\textbf{T}\\)

Then: \\(\textbf{U} = \textbf{W}^\textbf{+} = \textbf{Y}\textbf{Z}^\textbf{+}\textbf{X}^\textbf{T}\\), with<br/>
\\(\textbf{Z}^\textbf{+}\\) = reciprocals of non-zero singular values: \\(\textbf{Z}^\textbf{ii}\_\textbf{ii} = \frac{1}{\textbf{Z}\_\textbf{ii}}\\)

\\(\textbf{W}^\textbf{+}\\) is the "pseudo-inverse"

Note:
Information coming from https://www.youtube.com/watch?v=_kD34bgroGM

--NEWV
![cur](/images/cur.png)

--NEWV
**Applications for CUR decomposition**

Application 1: Human genetics

DNA SNP data: evaluate intra- and inter-population tag-SNP transferability

--NEWV
Application 2: Medical imaging

Hyperspectral image data: compress the data, without sacrificing classification quality

--NEWV
Tissue classification based on exact data

![classification-exact](/images/tissue-classification-exact.png)

--NEWV
Tissue classification based on compressed data

![classification-compressed](/images/tissue-classification-compressed.png)

--NEWV
Advantages CUR:
* easy to interpret (because basis vectors are actual columsn and rows)
* sparse basis

Disadvantages SVD:
* duplicate columns and rows

--NEWV
**How to get rid of duplicates?**

* Throw duplicates away
* Multiply those columns or rows by the square root of the number of duplicates

See [https://www.youtube.com/watch?v=FLBfWwojO6o](https://www.youtube.com/watch?v=FLBfWwojO6o) why sparseness is important

--NEWH
### II.4 Independent Component Analysis ICA

--NEWH
### II.5 t-SNE
