using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

namespace Dushe_h.TaskSystem
{
    public class Task : IComparable<Task>
	{
        public int priorityLevel;
        public string taskName;

        public int CompareTo(Task task)
        {
            return priorityLevel.CompareTo(task.priorityLevel);
        }
    }

    public class TaskExecutor
    {
        public List<Task> tasks;

        private bool enableSort;

        public bool EnableSort
        {
            get { return enableSort; }
            set { enableSort = value; }
        }

		public virtual void Execute() 
        {
            if (enableSort) tasks.Sort();   
        }
    }

    public class ExecutorSystem : MonoBehaviour
    {
        public List<TaskExecutor> executor;

		public void Update()
		{
			foreach (var exec in executor)
            {
                exec.Execute();
            }
		}
	}
}
