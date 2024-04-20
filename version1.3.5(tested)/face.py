import numpy as np
import cv2
import os
import time

from termcolor import colored




########## CNN CODE ############
def distance(v1, v2):
	# Eucledian 
	return np.sqrt(((v1-v2)**2).sum())

def knn(train, test, k=5):
	dist = []
	
	for i in range(train.shape[0]):
		# Get the vector and label
		ix = train[i, :-1]
		iy = train[i, -1]
		# Compute the distance from test point
		d = distance(test, ix)
		dist.append([d, iy])
	# Sort based on distance and get top k
	dk = sorted(dist, key=lambda x: x[0])[:k]
	# Retrieve only the labels
	labels = np.array(dk)[:, -1]
	
	# Get frequencies of each label
	output = np.unique(labels, return_counts=True)
	# Find max frequency and corresponding label
	index = np.argmax(output[1])
	return output[0][index]
################################

def check_person():
	user_name = ""
	cap = cv2.VideoCapture(0)
	time.sleep(0.5)
	face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_alt.xml")

	dataset_path = "./face_dataset/"

	face_data = []
	labels = []
	class_id = 0
	names = {}


	# Dataset prepration
	for fx in os.listdir(dataset_path):
		if fx.endswith('.npy'):
			names[class_id] = fx[:-4]
			data_item = np.load(dataset_path + fx)
			face_data.append(data_item)

			target = class_id * np.ones((data_item.shape[0],))
			class_id += 1
			labels.append(target)

	face_dataset = np.concatenate(face_data, axis=0)
	face_labels = np.concatenate(labels, axis=0).reshape((-1, 1))


	trainset = np.concatenate((face_dataset, face_labels), axis=1)


	font = cv2.FONT_HERSHEY_SIMPLEX
	ctr = 5
	while ctr != 0:
		print(colored("loop", "light_cyan"))
		ret, frame = cap.read()
		if ret == False:
			continue
		else:
			ctr -= 1
		# Convert frame to grayscale
		gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

		# Detect multi faces in the image
		faces = face_cascade.detectMultiScale(gray, 1.3, 5)

		for face in faces:
			x, y, w, h = face

			# Get the face ROI
			offset = 5
			face_section = frame[y-offset:y+h+offset, x-offset:x+w+offset]
			face_section = cv2.resize(face_section, (100, 100))

			out = knn(trainset, face_section.flatten())
			user_name = names[int(out)]
			if len(user_name) > 0:
				ctr = 0
				
			


	print(colored(user_name, "light_cyan"))
	cap.release()
	cv2.destroyAllWindows()
	return user_name

