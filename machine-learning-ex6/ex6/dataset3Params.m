function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_options = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
sigma_options = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

% Loop through to optimize C and sigma values
for C_entry = C_options
  for sigma_entry = sigma_options
    model = svmTrain(X, y, C_entry, @(x1, x2) gaussianKernel(x1, x2, sigma_entry));
    y_predicted = svmPredict(model, Xval);
    error = mean(double(y_predicted ~= yval));
    
    % Check if `current_error` variable is not defined
    if(exist("previous_error", "var") == 0)
      previous_error = error;
    end
    
    % Search for lowest error optimizing C and sigma
    if(previous_error > error)
      previous_error = error;
      C = C_entry;
      sigma = sigma_entry;
    end
  end
end

% =========================================================================

end
