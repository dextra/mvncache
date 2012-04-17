require 'net/http'

class ThreadsSynchronizer
  
  def initialize
    # Mutexes dictionary
    @mutexes = {}
    
    # Guarantees no entry will be added twice to the dictionary
    @mutex_creation_synchronization = Mutex.new
  end
  
  def synchronized_run_for_key(key, lambda_code)
    # Synchronizes on the key
    get_mutex_for_key(key).synchronize do
      
      # Calls client code
      lambda_code.call
      
      # Discards the now unnecessary mutex
      remove_mutex_for_key(key)
    end
  end
  
  def get_mutex_for_key(key)
    @mutex_creation_synchronization.synchronize do
      # Looks for an existing mutex
      existing_mutex = @mutexes[key]
      
      if existing_mutex
        return existing_mutex
      else
        # If none is found, one is created and stored
        return @mutexes[key] = Mutex.new
      end
    end
  end
  
  def remove_mutex_for_key(key)
    @mutexes.delete key
  end
  
end
