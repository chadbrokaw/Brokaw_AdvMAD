package com.chad.space.ui.search

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.chad.space.R
import com.chad.space.data.Space

class SearchRecyclerAdapter(val context: Context, val spaceList: List<Space>, val itemListener: SpaceItemListener) : RecyclerView.Adapter<SearchRecyclerAdapter.ViewHolder>() {

    //custom ViewHolder
    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val titleText = itemView.findViewById<TextView>(R.id.titleTextView)
        val dateText = itemView.findViewById<TextView>(R.id.prepTextView)
    }

    //inflate the view for the item
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.space_list_item, parent, false)
        return ViewHolder(view)
    }

    //number of items in RecyclerView
    override fun getItemCount() = spaceList.count()

    //set the data for the view
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val spaceData = spaceList[position]

        holder.titleText.text = spaceData.title
        holder.dateText.text = "${spaceData.date}"

        holder.itemView.setOnClickListener {
            itemListener.onSpaceItemClick((spaceData))
        }

    }

    interface SpaceItemListener {
        fun onSpaceItemClick(space: Space)
    }
}

